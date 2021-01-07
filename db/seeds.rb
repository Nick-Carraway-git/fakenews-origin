# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
chategories = Category.create([ { name: 'スポーツ' },
                                { name: '政治' },
                                { name: '科学' },
                                { name: '経済' },
                                { name: 'エンタメ' },
                                { name: '犯罪' },
                                { name: '医療' } ])
