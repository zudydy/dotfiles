#!/usr/bin/env zx

const homeDir = os.homedir();
const dotfilesDir = `${homeDir}/dotfiles`;

console.log("🔗 Linking dotfiles...");

const dotfiles = [
  { src: "zsh/.zshrc", target: ".zshrc" },
  { src: "starship/starship.toml", target: ".config/starship.toml" },
  { src: "wezterm/wezterm.lua", target: ".config/wezterm/wezterm.lua" },
];

// 백업 함수
for (const { target } of dotfiles) {
  const targetPath = `${homeDir}/${target}`;
  if (fs.existsSync(targetPath) && !fs.lstatSync(targetPath).isSymbolicLink()) {
    await $`mv ${targetPath} ${targetPath}.backup`;
    console.log(`📦 Backed up ${targetPath}`);
  }
}

// 심볼릭 링크 생성
for (const { src, target } of dotfiles) {
  const srcPath = `${dotfilesDir}/${src}`;
  const targetPath = `${homeDir}/${target}`;
  await $`ln -sf ${srcPath} ${targetPath}`;
  console.log(`✅ Linked ${targetPath}`);
}
