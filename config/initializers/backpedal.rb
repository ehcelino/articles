Backpedal.configure do |config|
  config.skipped_verbs = ['new', 'edit', 'create', 'destroy', 'like', 'unlike', 'login']
end