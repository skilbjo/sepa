sepa-pdf-&-html-generator
========================

Generates PDF via erb / html and wkhtmltopdf from a CSV. Written in Ruby by John Skilbeck.

Introduction
===
Simple program that does the following

	-I/O from a CSV, 
	-parses it,  
	-uses ERB for templating
	-creates a unique .pdf and .html for each record in the csv



Installation
===

Requires:

[ruby]: this was written in an Windows environment and I recommend [Rails Installer](http://railsinstaller.org/en) for the initial ruby installation 

[wkhtmltopdf]: [found here](https://code.google.com/p/wkhtmltopdf/)

[pdfkit]: [found here](https://github.com/pdfkit/pdfkit) or alternatively with ruby's package manager type the following in your console:
	
	$ gem install pdfkit


[ERB]: included as a default Ruby library

[CSV]: included as a default Ruby library

Usage
===

In a Windows environment we need to tell pdfkit where to find wkhtmltopdf with the following:

	PDFKit.configure do |config|
		config.wkhtmltopdf = 'C:\wkhtmltopdf\wkhtmltopdf.exe'
	end

Note: I installed wkhtmltopdf directly to my C:\ directory.


Customize the output directories with this little bit:

	Dir.mkdir('output') unless Dir.exists? 'output'
	Dir.mkdir('output/pdf') unless Dir.exists? 'output/pdf'
	filename = "output/letter_#{id}.html"
	file = kit.to_file("output/pdf/letter_#{id}.pdf")


Your CSV is file is titled csv-example.csv - feel free to change the headers and title! Just don't forget, if you change the file name, update

	contents = CSV.open 'input/input.csv', headers: true, header_converters: :symbol


And if you change the headers, update the header variables

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
	bic = row[:biccode]


Setting the erb variables in form-letter.rb like so:
	
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


and in form-letter.erb like this

	<h4>Customer Name: <%= firstname_erb %> <%= lastname_erb %></h4>
    <tr>
      <td>Bank Identification Code (BIC): </td>
      <td><%= bic_erb %></td>
    </tr>

Enjoy!
