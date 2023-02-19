require('dap-vscode-js').setup({
  node_path = 'node',
  debugger_path = os.getenv('HOME') .. '/projects/Github/microsoft/vscode-js-debug',
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})
