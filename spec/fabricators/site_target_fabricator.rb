Fabricator(:site_target) do
	site
	target
end

Fabricator(:contacted_site_target, from: :site_target) do
 	contacted DateTime.current
end