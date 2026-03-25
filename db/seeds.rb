require 'csv'

Book.destroy_all
Author.destroy_all

puts "Creating authors with Faker..."

50.times do
  Author.create!(
    name:        Faker::Book.author,
    nationality: Faker::Address.country,
    bio:         Faker::Lorem.paragraph(sentence_count: 2)
  )
end

puts "Created #{Author.count} authors."

author_ids = Author.pluck(:id)

puts "Loading books from CSV..."

csv_file = File.join(Rails.root, 'db', 'seeds', 'books.csv')

CSV.foreach(csv_file, headers: true) do |row|
  Book.create!(
    title:          row['title'],
    genre:          row['genre'],
    description:    row['description'],
    published_year: row['published_year'].to_i,
    author_id:      author_ids.sample
  )
end

puts "Loaded CSV books. Total books so far: #{Book.count}"

puts "Creating more books with Faker..."

150.times do
  Book.create!(
    title:          Faker::Book.title,
    genre:          Faker::Book.genre,
    description:    Faker::Lorem.sentence(word_count: 12),
    published_year: rand(1900..2023),
    author_id:      author_ids.sample
  )
end

puts "Done! Total rows: Authors=#{Author.count}, Books=#{Book.count}"
puts "Grand total rows: #{Author.count + Book.count}"