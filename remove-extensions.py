def on_config(config):
    if 'mdx_truly_sane_lists' in config['markdown_extensions']:
        config['markdown_extensions'].remove('mdx_truly_sane_lists')
    return config
