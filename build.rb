require 'redcarpet'

MD_SCRIPTS_LOCATION = '..'
DOCUMENTS_WITH_CITES = ['_Диссертация.md']
DOCUMENTS_CONVERT = ['_Диссертация.md', '_Автореферат.md']

puts 'Combine ...'
system("ruby #{MD_SCRIPTS_LOCATION}/md-include/md-include.rb .")

puts 'Build references ...'
DOCUMENTS_WITH_CITES.each do |doc|
  system("ruby #{MD_SCRIPTS_LOCATION}/md-cites/md-cites.rb #{doc} #{doc}")
end

DOCUMENTS_CONVERT.each do |doc|
  file = File.read(doc)
  html = Redcarpet::Markdown.new(Redcarpet::Render::HTML, no_intra_emphasis: true, tables: true).render(file)
  name_only = doc.match(/^(.*?)\.[^\.]+$/)[1]
  File.open("#{name_only}.html",'w') { |f| f << html }
end

puts 'Finish'
