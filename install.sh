#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
	echo "Usage: $0 <target-dir>" >&2
	exit 1
fi

link_path() {
	local src="$1"
	local link="$2"

	if [ -e "$link" ] || [ -L "$link" ]; then
		if [ -L "$link" ] && [ "$(readlink "$link")" = "$src" ]; then
			echo "Already linked: $link"
			return
		fi
		echo "Refusing to overwrite existing path: $link" >&2
		exit 1
	fi

	ln -s "$src" "$link"
	echo "Linked $link -> $src"
}

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="$1"

if [ ! -d "$target_dir" ]; then
	echo "Target directory does not exist: $target_dir" >&2
	exit 1
fi

target_dir="$(cd "$target_dir" && pwd)"

opencode_subdir=".opencode"
if [ "$target_dir" = "$HOME" ]; then
	opencode_subdir=".config/opencode"
fi

for harness_subdir in .claude "$opencode_subdir"; do
	harness_dir="$target_dir/$harness_subdir"

	skills_src_dirs=("$repo_dir/skills" "$repo_dir/skills-trial")
	agents_src_dirs=("$repo_dir/agents")

	for name in skills agents; do
		dest_dir="$harness_dir/$name"
		mkdir -p "$dest_dir"

		src_dirs_var="${name}_src_dirs[@]"
		for src_dir in "${!src_dirs_var}"; do
			for item in "$src_dir"/*; do
				link_path "$item" "$dest_dir/$(basename "$item")"
			done
		done
	done

	link_path "$repo_dir/AGENTS.md" "$harness_dir/AGENTS.md"

	# CLAUDE.md only imports AGENTS.md, so it is of no use to other harnesses.
	if [ "$harness_subdir" = ".claude" ]; then
		link_path "$repo_dir/CLAUDE.md" "$harness_dir/CLAUDE.md"
	fi
done
