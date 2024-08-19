function psg --wraps='ps aux | grep ' --description 'alias psg=ps aux | grep '
  ps aux | grep  $argv
        
end
