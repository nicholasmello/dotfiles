function list-archive-contents --description "Recursively list contents of zip and tar archives"
    argparse --name=list-archive-contents h/help 'o=' -- $argv
    or return 1

    function print_help
        echo "
Usage: list-archive-contents [-h] [-o output_file] archive1 [archive2 ...]

Recursively lists the contents of zip and tar files, including nested archives.

Options:
  -h, --help          Show this help message and exit
  -o output_file      Write output to the specified file instead of printing
"
    end

    if set -q _flag_help
        print_help
        return 0
    end

    set -g output_file ""
    if set -q _flag_o
        set output_file $_flag_o
        rm -rf $output_file
    end

    set -l args $argv

    if test (count $args) -eq 0
        print_help
        return 0
    end

    # Print indentation as real tabs
    function _indent
        set -l level $argv[1]
        printf "%s" (string repeat $level "    ")
    end

    # Print line with indentation, to file or stdout
    function _print
        set -l depth $argv[1]
        set -l message $argv[2..-1]
        set -l indent (_indent $depth)
        if test -n "$output_file"
            printf "%s%s\n" $indent $message >>"$output_file"
        else
            printf "%s%s\n" $indent $message
        end
    end

    function list_contents_recursive
        set -l file $argv[1]
        set -l depth $argv[2]

        if not test -f "$file"
            _print $depth "File not found: $file"
            return
        end

        # Show only basename in header to hide /tmp/
        set -l display_file (basename -- "$file")
        _print $depth "📦 $display_file"

        set -l ext (string lower $display_file)

        switch $ext
            case '*.zip'
                set -l tmpdir (mktemp -d)
                unzip -q "$file" -d "$tmpdir"

                # Gather nested archives
                set -l nested_archives (find "$tmpdir" -type f \( -iname '*.zip' -o -iname '*.tar' -o -iname '*.tar.gz' -o -iname '*.tgz' -o -iname '*.tar.bz2' -o -iname '*.tbz2' -o -iname '*.tar.xz' -o -iname '*.txz' \))

                # Print normal files (excluding nested archives)
                find "$tmpdir" -type f | while read -l inner
                    if contains -- "$inner" $nested_archives
                        continue
                    end
                    set -l relpath (string replace -- "$tmpdir/" "" "$inner")
                    _print (math $depth + 1) "$relpath"
                end

                # Recurse into each nested archive
                for nested in $nested_archives
                    list_contents_recursive "$nested" (math $depth + 1)
                end

                rm -rf "$tmpdir"

            case '*.tar' '*.tar.gz' '*.tgz' '*.tar.bz2' '*.tbz2' '*.tar.xz' '*.txz'
                set -l tmpdir (mktemp -d)
                switch $ext
                    case '*.tar'
                        tar -xf "$file" -C "$tmpdir"
                    case '*.tar.gz' '*.tgz'
                        tar -xzf "$file" -C "$tmpdir"
                    case '*.tar.bz2' '*.tbz2'
                        tar -xjf "$file" -C "$tmpdir"
                    case '*.tar.xz' '*.txz'
                        tar -xJf "$file" -C "$tmpdir"
                end

                # Find nested archives in extracted tree
                set -l nested_archives (find "$tmpdir" -type f \( -iname '*.zip' -o -iname '*.tar' -o -iname '*.tar.gz' -o -iname '*.tgz' -o -iname '*.tar.bz2' -o -iname '*.tbz2' -o -iname '*.tar.xz' -o -iname '*.txz' \))

                # Print all files except nested archives themselves
                find "$tmpdir" -type f | while read -l inner
                    if contains -- "$inner" $nested_archives
                        continue
                    end
                    set -l relpath (string replace -- "$tmpdir/" "" "$inner")
                    _print (math $depth + 1) "$relpath"
                end

                # Recurse into nested archives
                for nested in $nested_archives
                    list_contents_recursive "$nested" (math $depth + 1)
                end

                rm -rf "$tmpdir"

            case '*'
                _print $depth "❌ Unsupported file format: $file"
        end
    end

    for arg in $args
        for file in (eval echo $arg)
            list_contents_recursive "$file" 0
        end
    end
end
