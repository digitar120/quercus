if test "$argv[2]" = null
    echo "Faltan argumentos."
    exit 1
end

rsync -a --ignore-existing --info=progress2 $argv[1] $argv[2]
