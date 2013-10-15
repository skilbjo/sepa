require 'csv'
require 'erb'
require 'pdfkit'

PDFKit.configure do |config|
  config.wkhtmltopdf = 'C:\wkhtmltopdf\wkhtmltopdf.exe'
end

def save_letters(id,form_letter)
	Dir.mkdir('output/html') unless Dir.exists? 'output'
	Dir.mkdir('output/pdf') unless Dir.exists? 'output/pdf'
	filename = "output/html/letter_#{id}.html"

	# generate HTML
	File.open(filename,'w') do |file|
		file.puts form_letter
	end

	# generate PDF
	kit = PDFKit.new(form_letter)
	file = kit.to_file("output/pdf/letter_#{id}.pdf")

end

# read ERB file (ERB contains HTML code)
template_letter = File.read 'sepa.erb'
# create new ERB template by passing required variable
erb_template = ERB.new template_letter

# open and parse csv
contents = CSV.open 'csv-example.csv', headers: true, header_converters: :symbol

contents.each do |row|
	# set data variables using headers in CSV
	id=row[:id]
	first_name = row[:first_name]
	last_name = row[:last_name]
	address1 = row[:address1]
	address2 = row[:address2]
	address3 = row[:address3]
	balance = row[:balance]

	# set erb variables
	amount = balance
	name = first_name

	# fill out erb template
	form_letter = erb_template.result(binding)
	save_letters(id,form_letter)
end

puts 'Letters initialized.'