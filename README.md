pdf-generator-using-ruby
========================

Generates PDF via erb / html and wkhtmltopdf from a CSV. Written in Ruby.

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

	contents = CSV.open 'csv-example.csv', headers: true, header_converters: :symbol


And if you change the headers, update the header variables

	id=row[:id]
	first_name = row[:first_name]
	last_name = row[:last_name]
	address1 = row[:address1]
	address2 = row[:address2]
	address3 = row[:address3]
	balance = row[:balance]


Setting the erb variables in form-letter.rb like so:
	
	amount = balance
	name = first_name


and in form-letter.erb like this

	<h3>Dear <%= first_name %>,</h3>
	<p>Your adjustment amount is $<%= amount %>.</p>

Enjoy!
