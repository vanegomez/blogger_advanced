require 'capybara/poltergeist'

desc "Simulate load against Blogger application"
task :load_test => :environment do
  4.times.map { Thread.new { browse } }.map(&:join)
end

def browse
  session = Capybara::Session.new(:poltergeist)
  loop do
    session.visit('https://bloggeradvanced.herokuapp.com')
    puts session.current_path
    session.all("li.article a").sample.click
    puts session.current_path
    session.fill_in "comment[author_name]", with: "Name"
    session.fill_in "comment[body]", with: "Comments about article"
    session.click_button("Save")
    puts session.current_path
  end
end
