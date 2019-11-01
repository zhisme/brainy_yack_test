20.times do
  story = Story.create(name: Faker::Book.unique.title)
  Article.create(name: Faker::Book.unique.title, story: story, kind: Article.kinds.values.sample, text: Faker::Movies::Hobbit.quote)
end

story = Story.create(name: Faker::Book.unique.title)
5.times do
  Article.create(name: Faker::Book.unique.title, story: story, kind: Article.kinds.values.sample, text: Faker::Movies::StarWars.quote)
end
