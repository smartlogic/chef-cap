def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to, :via => :scp
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end
