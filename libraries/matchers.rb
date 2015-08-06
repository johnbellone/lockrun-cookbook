if defined?(ChefSpec)
  def create_lockrun_cron(name)
    ChefSpec::Matchers::ResourceMatcher.new(:lockrun_cron, :create, name)
  end

  def delete_lockrun_cron(name)
    ChefSpec::Matchers::ResourceMatcher.new(:lockrun_cron, :delete, name)
  end
end
