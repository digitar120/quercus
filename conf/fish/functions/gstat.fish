function gstat --wraps='git status' --description 'alias gstat=git status'
  clear && git status $argv
        
end
