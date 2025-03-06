import os
import re
import pathlib
import argparse
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
    parser = argparse.ArgumentParser()
    parser.add_argument('template_path')
    parser.add_argument('output_path')
    args = parser.parse_args()

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

    content = load_template(args.template_path).render(datasets=datasets)
    write_file(args.output_path, content)
