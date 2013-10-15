require 'csv'
require 'erb'
require 'pdfkit'

PDFKit.configure do |config|
  config.wkhtmltopdf = 'C:\wkhtmltopdf\wkhtmltopdf.exe'
end

def save_letters(id,form_letter)
	Dir.mkdir('output/html') unless Dir.exists? 'output/html'
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
contents = CSV.open 'input/input.csv', headers: true, header_converters: :symbol

contents.each do |row|

		# set data variables using headers in CSV
		id=row[:id]
		firstname = row[:firstname]
		lastname = row[:lastname]
		applicant_email = row[:applicant_email]
		listing_name = row[:listing_name]
		address = row[:address]
		city = row[:city]
		state = row[:state]
		postalcode = row[:postalcode]
		country = row[:country]
		mandate_old = row[:mandate_old]
		mandate_new = row[:mandate_new]
		mandate_date = row[:mandate_date]
		bic = row[:biccode]

		# set erb variables
		firstname_erb = firstname
		lastname_erb = lastname
		listing_name_erb = listing_name
		address_erb = address
		city_erb = city
		state_erb = state
		postalcode_erb = postalcode
		country_erb = country
		mandate_old_erb = mandate_old
		mandate_new_erb = mandate_new
		bic_erb = bic
		mandate_date_erb = mandate_date


		# fill out erb template
		form_letter = erb_template.result(binding)
		save_letters(id,form_letter)
end

puts 'Letters completed.'