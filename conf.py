import sphinx_rtd_theme

# -- Project information -----------------------------------------------------

project = 'Satisfactory Modding Documentation'
copyright = '2019, Panakotta00'
author = 'Panakotta00'


# -- General configuration ---------------------------------------------------

extensions = [
    'sphinx_rtd_theme',
]

templates_path = ['_templates']

exclude_patterns = ['docs', 'Thumbs.db', '.DS_Store']


# -- Options for HTML output -------------------------------------------------

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']