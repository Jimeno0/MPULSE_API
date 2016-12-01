# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(name: "jimeno0", email:"carlos@carlos.com", password:"123123123")
user2 = User.create(name: "Laura", email:"laura@laura.com", password:"123123123")
User.create(name: "Miguel", email:"miguel@miguel.com", password:"123123123")
User.create(name: "Daichi", email:"daichi@daichi.com", password:"123123123")
User.create(name: "Victor", email:"victor@victor.com", password:"123123123")

artist = Artist.create(name: 'Bonobo')

concert1 = artist.concerts.create(
  name: "Bonobo live",
  date: "2016-12-01",
  url: "http://www.ticketweb.com/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=6970105&REFERRAL_ID=tmfeed",
  genre: "Rock",
  subgenre: "Pop",
  sale: true,
  image: "https://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_CUSTOM.jpg",
  lat: "41.81595297",
  lon: "-71.44339174",
  city: "Madrid",
  venue: "O2",
  concert_id: "1AtZAAoGkdUFKGV",
  country: "Spain"
  )

concert2 = artist.concerts.create(
  name: "Dope Basel 2016",
  date: "2016-12-01",
  url: "http://www.ticketweb.com/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=7024855&REFERRAL_ID=tmfeed",
  genre: "Other",
  subgenre: "Other",
  country: "United States Of America",
  lat: "25.784676",
  lon: "-80.192899",
  city: "Miami",
  venue: "Heart Nightclub",
  concert_id: "1Ae0ZfpGkzN5Dpp",
  sale: true,
  image: "https://s1.ticketm.net/dam/c/060/c5c08e7a-9912-456c-a060-2758be94e060_105881_CUSTOM.jpg"
)

user1.concerts.push(concert1)
user2.concerts.push(concert1)
user1.concerts.push(concert2)