local dap = require("dap")

require("dap-vscode-js").setup({
  node_path = os.getenv("HOME") .. "/.nvm/versions/node/v22.3.0/bin/node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = {
    "chrome",
    "pwa-node",
    "pwa-chrome",
    "pwa-msedge",
    "node-terminal",
    "pwa-extensionHost",
    "node",
    "chrome",
  }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
  dap.configurations[language] = {
    {
      name = "アクティブなtsファイルをデバッグ",
      type = "pwa-node", --利用するデバッガの種類をVSCodeに伝える。"node"でも良いが、"pwa-node"の方が新しいデバッガのためこちらを利用(progressive web apps とは関係ない)
      request = "launch", -- デバッガ起動時に、対象プログラム("program")を起動する
      -- runtimeArgs = { "--nolazy", "-r", "ts-node" }, -- ts-nodeを読み込みます(nolazyは無くても動きます。V8エンジンにスクリプト解析を延滞させないためのオプション(指定しないとブレークポイントスキップする可能性があるため))
      runtimeArgs = { "--nolazy", "--loader", "ts-node/esm" },
      -- args = { "${file}", "--transpile-only" }, -- デバッグを開始するファイルを指定する。「${file}」はアクティブなファイルのフルパス(開いているファイルをデバッグする)
      args = { "${file}" }, -- デバッグを開始するファイルを指定する。「${file}」はアクティブなファイルのフルパス(開いているファイルをデバッグする)
      cwd = "${workspaceFolder}",
      -- resolveSourceMapLocations = {
      --   "${workspaceFolder}/dist/**/*.js",
      --   "${workspaceFolder}/dist/*.js",
      --},
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      env = { "TS_NODE_PROJECT", "${workspaceFolder}/tsconfig.json" },
    },
    {
      name = "アクティブなtsファイルをデバッグ（Suppress Deprecation Warning）",
      type = "pwa-node", --利用するデバッガの種類をVSCodeに伝える。"node"でも良いが、"pwa-node"の方が新しいデバッガのためこちらを利用(progressive web apps とは関係ない)
      request = "launch", -- デバッガ起動時に、対象プログラム("program")を起動する
      -- runtimeArgs = { "--nolazy", "-r", "ts-node" }, -- ts-nodeを読み込みます(nolazyは無くても動きます。V8エンジンにスクリプト解析を延滞させないためのオプション(指定しないとブレークポイントスキップする可能性があるため))
      runtimeArgs = { "--no-deprecation", "--import", "./ts-node.register.mjs" },
      -- args = { "${file}", "--transpile-only" }, -- デバッグを開始するファイルを指定する。「${file}」はアクティブなファイルのフルパス(開いているファイルをデバッグする)
      args = { "${file}" }, -- デバッグを開始するファイルを指定する。「${file}」はアクティブなファイルのフルパス(開いているファイルをデバッグする)
      cwd = "${workspaceFolder}",
      -- resolveSourceMapLocations = {
      --   "${workspaceFolder}/dist/**/*.js",
      --   "${workspaceFolder}/dist/*.js",
      -- },
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      env = { "TS_NODE_PROJECT", "${workspaceFolder}/tsconfig.json", "NODE_OPTIONS", "--nodeprecation" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      -- 追加
      runtimeExecutable = "${workspaceFolder}/node_modules/.bin/ts-node",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },

    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      -- 追加
      resolveSourceMapLocations = {
        "${workspaceFolder}/dist/**/*.js",
        "${workspaceFolder}/dist/*.js",
      },
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = 'Start Chrome with "Launch file"',
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
    },
  }
end
