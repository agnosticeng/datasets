import os
import re
import pathlib
import json 
from jinja2 import Template

def load_template(path):
    with open(path) as f:
        template = Template(f.read())
        return template

def read_file(path):
    with open(path) as f:
        return f.read()

def write_file(path, content):
    with open(path, 'w') as f:
        f.write(content)

if __name__ == '__main__':
    cwd = pathlib.Path(".")

    datasets = {}

    for file in cwd.rglob('*.sql'):
        meta = {}
        meta['name'] = file.stem
        meta['table_name'] = file.parents[0].as_posix().replace('/', '__') + '__' + file.stem
        file_content = read_file(file.as_posix())
        match = re.search(r'.*\$comment\$*([^$]+)\$comment\$.*', file_content)

        if match and match.group and match.group(1):
            comment = json.loads(match.group(1))

            if comment.get('short'):
                meta['short'] = comment.get('short')

        items = datasets.get(file.parents[0].as_posix(), [])
        items.append(meta)
        datasets[file.parents[0].as_posix()] = items

    content = load_template(os.path.join(os.path.dirname(__file__), 'datasets.md.tmpl')).render(datasets=datasets)
    write_file(os.path.join(os.path.dirname(__file__), 'datasets.md'), content)
