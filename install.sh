#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
	echo "Usage: $0 <target-dir>" >&2
	exit 1
fi

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
				item_name="$(basename "$item")"
				link="$dest_dir/$item_name"
				if [ -e "$link" ] || [ -L "$link" ]; then
					if [ -L "$link" ] && [ "$(readlink "$link")" = "$item" ]; then
						echo "Already linked: $link"
						continue
					fi
					echo "Refusing to overwrite existing path: $link" >&2
					exit 1
				fi
				ln -s "$item" "$link"
				echo "Linked $link -> $item"
			done
		done
	done

	agents_md="$harness_dir/AGENTS.md"
	if [ -e "$agents_md" ] || [ -L "$agents_md" ]; then
		if [ -L "$agents_md" ] && [ "$(readlink "$agents_md")" = "$repo_dir/AGENTS.md" ]; then
			echo "Already linked: $agents_md"
		else
			echo "Refusing to overwrite existing path: $agents_md" >&2
			exit 1
		fi
	else
		ln -s "$repo_dir/AGENTS.md" "$agents_md"
		echo "Linked $agents_md -> $repo_dir/AGENTS.md"
	fi
done
