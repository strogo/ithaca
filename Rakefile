# Setup
verbose(false)
task :default => :push

desc "Run jekyll command and upload to my htdocs dir."
task :sync do
	sh %{jekyll}
	login = 'telemachus@login.geekisp.com'
	htdocs = '/home/telemachus/www.arpinum.org/htdocs/ithaca'
	remote = login + ':' + htdocs
	sh %{rsync -rtz --delete _site/ #{remote}/}
end

desc "Upload to htdocs dir without a full re-jekylling"
task :push do
	login = 'telemachus@login.geekisp.com'
	htdocs = '/home/telemachus/www.arpinum.org/htdocs/ithaca'
	remote = login + ':' + htdocs
	sh %{rsync -rtz --delete _site/ #{remote}/}
end
