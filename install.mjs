#!/usr/bin/env zx

const homeDir = os.homedir();
const dotfilesDir = `${homeDir}/dotfiles`;

console.log("🔗 Linking dotfiles...\n");

// ------------------------
// dotfiles 정의
// ------------------------
const DOTFILES_MAP = {
  nvim: {
    src: "nvim",
    target: ".config/nvim",
  },
  wezterm: {
    src: "wezterm",
    target: ".config/wezterm",
  },
  starship: {
    src: "starship/starship.toml",
    target: ".config/starship.toml",
  },
  zsh: {
    src: "zsh/.zshrc",
    target: ".zshrc",
  },
  "leader-key": {
    src: "leader-key/config.json",
    target: "Library/Application Support/Leader Key/config.json",
  },
};

// ------------------------
// utils
// ------------------------
function ensureDir(targetPath) {
  const dir = path.dirname(targetPath);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
    console.log(`📁 Created directory: ${dir}`);
  }
}

function backupIfNeeded(targetPath) {
  if (!fs.existsSync(targetPath)) return;

  const stat = fs.lstatSync(targetPath);

  // 이미 symlink면 스킵
  if (stat.isSymbolicLink()) return;

  const backupPath = `${targetPath}.backup.${Date.now()}`;
  fs.renameSync(targetPath, backupPath);
  console.log(`📦 Backed up → ${backupPath}`);
}

async function link(src, target) {
  const srcPath = path.join(dotfilesDir, src);
  const targetPath = path.join(homeDir, target);

  ensureDir(targetPath);
  backupIfNeeded(targetPath);

  await $`ln -sfn ${srcPath} ${targetPath}`;
  console.log(`✅ Linked ${target} → ${src}`);
}

// ------------------------
// args 처리 (핵심 수정 부분)
// ------------------------
const args = process.argv.slice(2).filter((arg) => !arg.endsWith(".mjs"));

if (args.length === 0) {
  console.error("❌ No arguments provided.");
  console.error("👉 Usage:");
  console.error("   zx install.mjs all");
  console.error("   zx install.mjs nvim wezterm");
  process.exit(1);
}

let selected = [];

if (args.includes("all")) {
  selected = Object.keys(DOTFILES_MAP);
} else {
  selected = args;

  for (const name of selected) {
    if (!DOTFILES_MAP[name]) {
      console.error(`❌ Unknown target: ${name}`);
      console.error(`👉 Available: ${Object.keys(DOTFILES_MAP).join(", ")}`);
      process.exit(1);
    }
  }
}

// ------------------------
// 실행
// ------------------------
for (const name of selected) {
  const { src, target } = DOTFILES_MAP[name];
  await link(src, target);
}

console.log("\n✨ Done.");
