import os
import chdb
from jinja2 import Template
import yaml

url_patterns = {
    'daily': 'https://data.ethpandaops.io/xatu/%s/databases/default/%s/2025/1/1.parquet',
    'hourly': 'https://data.ethpandaops.io/xatu/%s/databases/default/%s/2025/1/1/0.parquet'
}

def load_template(path):
    with open(path) as f:
        template = Template(f.read())
        return template

def load_config(path):
    with open(path) as f:
        return yaml.safe_load(f)

def write_file(path, content):
    with open(path, 'w') as f:
        f.write(content)

if __name__ == '__main__':
    cnf = load_config(os.path.join(os.path.dirname(__file__), 'tables.yaml'))

    for f in cnf.get('tables', []):
        if len(f.get('url', '')) > 0:
            url = f.get('url')
        else: 
            url = url_patterns[f.get('url_pattern', 'daily')] % (f.get('network'), f.get('dataset'))

        query = "describe url('%s')" % url
        print("generating %s: %s" % (f.get('dataset'), query))

        columns = chdb.query(query, 'Dataframe').to_dict('records')
        path = os.path.join(os.path.dirname(__file__), f.get('network'), f.get('dataset')+'.sql')
        template_path = os.path.join(os.path.dirname(__file__), f.get('template'))

        content = load_template(template_path).render(
            columns=columns, 
            dataset=f.get('dataset'), 
            network=f.get('network'),
            doc_short=f.get('doc_short', ''),
            doc_url=f.get('doc_url', ''),
            doc_usage=Template(f.get('doc_usage', '')).render(f)
        )

        write_file(path, content)