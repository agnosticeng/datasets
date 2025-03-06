import os
import argparse 
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
    parser = argparse.ArgumentParser()
    parser.add_argument('config_file')
    args = parser.parse_args()

    cnf = load_config(args.config_file)

    for f in cnf.get('files', []):
        print("generating %s" % f.get('dataset'))

        if len(f.get('url', '')) > 0:
            url = f.get('url')
        else: 
            url = url_patterns[f.get('url_pattern', 'daily')] % (f.get('network'), f.get('dataset'))

        columns = chdb.query("describe url('%s')" % url, 'Dataframe').to_dict('records')
        path = os.path.join(os.path.dirname(__file__), f.get('network'), f.get('dataset')+'.sql')
        template_path = os.path.join(os.path.dirname(__file__), f.get('template'))

        content = load_template(template_path).render(
            columns=columns, 
            dataset=f.get('dataset'), 
            network=f.get('network'),
            doc_short=f.get('doc_short', ''),
            doc_url=f.get('doc_url', '')
        )

        write_file(path, content)