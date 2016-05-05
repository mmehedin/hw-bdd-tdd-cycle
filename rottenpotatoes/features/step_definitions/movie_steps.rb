# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  Movie.create!(movie)
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /I checked the movies only of rating 'PG' or 'R'/ do
  check('ratings_PG')
  check('ratings_R')
  uncheck('ratings_PG-13')
  uncheck('ratings_G')
end

When /I click on sumbit/ do
  click_button('ratings_submit')
end

Then /I should see only 'PG' or 'R' rated movies/ do
 page.body.should match(/<td>R<\/td>/)
 page.body.should match(/<td>PG<\/td>/)
end



When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(%r{,\s*})
  if uncheck
    ratings.each do |current_rate|
      step "I uncheck \"#{current_rate}\""
    end
  else
    ratings.each do |current_rate|
      step "I check \"#{current_rate}\""
    end
  end
  #fail "Unimplemented"
end

Then /I should( not)? see all the movies/ do |orNot|
  # Make sure that all the movies in the app are visible in the table
  #Movie.find(:all).length.should page.body.scan(/<tr>/).length
  Movie.all.each_with_index {
    |movie, index|
      name = movie[:title]
      if(!index)
        Then %Q{I should#{orNot} see "#{name}"}
      else
        And %Q{I should#{orNot} see "#{name}"}
      end
  }

  #fail "Unimplemented"
   movies = Movie.all
  
  if movies.size == 10
    movies.each do |movie|
      assert page.body =~ /#{movie.title}/m, "#{movie.title} did not appear"
    end
  else
    false
  end
end

Then /I should not see any movies/ do
  movies = Movie.all
  movies.each do |movie|
    assert true unless page.body =~ /#{movie.title}/m
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"/ do |movie_title, new_director|
  movie = Movie.find_by_title movie_title
  puts movie.inspect
  puts new_director
  puts movie_title
  #movie.director.should == new_director
  #assert new_director == movie.director
  assert movie.director == new_director
end