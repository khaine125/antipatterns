# originalan kod
class RemoteProcess < ActiveRecord::Base
  def self.find_top_running_processes(limit = 5)
    find(:all,
         conditions: "state = 'running'",
         order: "percent_cpu_desc",
         limit: limit)
  end

  def self.fint_top_running_system_processes(limit = 5)
    find(:all,
         conditions: "state = 'running' and
                     (owner in ('root', 'mysql')",
         order: "percent_cpu_desc",
         limit: limit)
  end
end

# refactor sa scope
class RemoteProcess < ActiveRecord::Base
  scope :running, where(state: 'running')
  scope :system, where(owner: ['root', 'mysql'])
  scope :sorted, order("percent_cpu_desc")
  scope :top, lambda {|l| limit(l)}

  def self.find_top_running_processes(limit = 5)
    running.sorted.top(limit)
  end

  def self.fint_top_running_system_processes(limit = 5)
    running.system.sorted.top(limit)
  end
end
