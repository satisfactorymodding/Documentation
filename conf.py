import sphinx_rtd_theme

# -- Project information -----------------------------------------------------

project = 'Satisfactory Modding Documentation'
copyright = '2019, SatisfactoryModding'
author = 'Panakotta00, SuperCoder79'

# -- General configuration ---------------------------------------------------

extensions = [
    'sphinx_rtd_theme',
]

templates_path = ['_templates']

exclude_patterns = ['docs', 'Thumbs.db', '.DS_Store']


# -- Options for HTML output -------------------------------------------------

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
html_logo = 'logo.png'
html_favicon = 'favicon-32x32.png'
html_theme_options = {
    "navigation_depth": 4
}