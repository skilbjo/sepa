require 'csv'
require 'erb'
require 'pdfkit'

PDFKit.configure do |config|
  config.wkhtmltopdf = 'C:\wkhtmltopdf\wkhtmltopdf.exe'
end

def save_letters_en(id,form_letter)
	Dir.mkdir('output/en/html') unless Dir.exists? 'output/en/html'
	Dir.mkdir('output/en/pdf') unless Dir.exists? 'output/en/pdf'
	filename = "output/en/html/letter_#{id}.html"
	# generate HTML
	File.open(filename,'w') do |file|
		file.puts form_letter
	end
	# generate PDF
	kit = PDFKit.new(form_letter)
	file = kit.to_file("output/en/pdf/letter_#{id}.pdf")
end

def save_letters_de(id,form_letter)
	Dir.mkdir('output/de/html') unless Dir.exists? 'output/de/html'
	Dir.mkdir('output/de/pdf') unless Dir.exists? 'output/de/pdf'
	filename = "output/de/html/letter_#{id}.html"
	# generate HTML
	File.open(filename,'w') do |file|
		file.puts form_letter
	end
	# generate PDF
	kit = PDFKit.new(form_letter)
	file = kit.to_file("output/de/pdf/letter_#{id}.pdf")
end

def save_letters_fr(id,form_letter)
	Dir.mkdir('output/fr/html') unless Dir.exists? 'output/fr/html'
	Dir.mkdir('output/fr/pdf') unless Dir.exists? 'output/fr/pdf'
	filename = "output/fr/html/letter_#{id}.html"
	# generate HTML
	File.open(filename,'w') do |file|
		file.puts form_letter
	end
	# generate PDF
	kit = PDFKit.new(form_letter)
	file = kit.to_file("output/fr/pdf/letter_#{id}.pdf")
end

# read ERB file (ERB contains HTML code)
template_letter_en = File.read 'sepa_en.erb'
template_letter_de = File.read 'sepa_de.erb'
template_letter_fr = File.read 'sepa_fr.erb'
# create new ERB template by passing required variable
erb_template_en = ERB.new template_letter_en
erb_template_de = ERB.new template_letter_de
erb_template_fr = ERB.new template_letter_fr

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
		language = row[:language]

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

		if language.eql?("English")
			# fill out erb template
			form_letter_en = erb_template.result(binding)
			save_letters_en(id,form_letter)
		end

		if language.eql?("German")
			# fill out erb template
			form_letter_de = erb_template.result(binding)
			save_letters_de(id,form_letter)
		end

		if language.eql?("French")
			# fill out erb template
			form_letter_fr = erb_template.result(binding)
			save_letters_fr(id,form_letter)
		end
end

puts 'Letters completed.'