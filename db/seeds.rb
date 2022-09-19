# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# ADMIN ACCOUNT
Author.create!(email: 'admin@test.com', first_name: 'Admin', last_name: 'Account', role: 'admin',
               confirmed_at: Time.zone.now, password: '12345678')

# MODERATOR ACCOUNT
Author.create!(email: 'moderator@test.com', first_name: 'Moderator', last_name: 'Account', role: 'moderator',
               confirmed_at: Time.zone.now, password: '12345678')

# 2 AUTHOR ACCOUNTS
author1 = Author.create!(email: 'Author1@test.com', first_name: 'Author 1', last_name: 'Account', role: 'author',
                         confirmed_at: Time.zone.now, password: '12345678')

author2 = Author.create!(email: 'Author2@test.com', first_name: 'Author 2', last_name: 'Account', role: 'author',
                         confirmed_at: Time.zone.now, password: '12345678')

# POSTS

post1 = Post.new(
  author: Author.find(author1.id),
  title: '5 takeaways after Sri Lanka outsmart Pakistan in Asia Cup final',
  description: 'If you zoom out and take a macro view, what happened in the final wouldn’t seem out of place.',
  content: "<div><strong>1. Ominous signs ahead of T20 World Cup</strong></div><div>If you zoom out and take a macro view, what happened in the final wouldn’t seem out of place. Of the six matches played in the entire tournament, Pakistan lost three, and of the three they won, two could have gone either way.<br><br></div><div>They went Pakistan’s way only because of individual heroics. Thus, the only match this team was clearly good at was against <a href=\"https://www.dawn.com/news/1708046\">Hong Kong,</a> which explains it all.<br><br></div><div>With the T20 World Cup a little over a month away, these are worrying signs. If the team couldn’t do it against Sri Lanka on a familiar Dubai wicket, God help them in Australia where the grounds are bigger and the ball jumps higher.<br><br></div><div><strong>2. Babar the batsman gets a pass, Babar the captain doesn’t</strong></div><div>The team, despite its obvious flaws, had somehow dragged itself to the final. What happened then was a series of gaffes and blunders, the first of which was from none other than the captain himself.<br><br></div><div>With half the Sri Lankan team back in the dugout, Babar Azam inexplicably went for a defensive approach that would have made prime Misbahul Haq proud.<br><br></div><div>Furthermore, for reasons unknown, Iftikhar Ahmed bowled three overs when he hadn’t bowled even one in all of the previous matches of the tournament.<br><br></div><div>Granted that Iftikhar did not prove expensive and picked up a wicket too, but that was the time to capitalise, go for the jugular and bundle out the Lankans under 100.<br><br></div><div>This was a tournament to forget for Babar for more reasons than one.<br><br></div><div>His immense goodwill means that no one is going to raise a finger at his batting failures but the captaincy decisions will be scrutinised as they should be.<br><br></div><div><strong>3. Cautious early, carefree later equals recipe for disaster</strong></div><div><br></div><div><figure data-trix-attachment='{\"contentType\":\"image\",\"url\":\"https://i.dawn.com/large/2022/09/12141422c7b16a7.jpg\",\"width\":800,\"height\":480}' data-trix-attributes='{\"caption\":\"M Rizwan\"}'></figure></div><div>Mohammad Rizwan in action in the Asia Cup 2022 final between Pakistan and Sri Lanka at the Dubai International Stadium, Dubai, United Arab Emirates, Sept 11. — Reuters</div><div>The foundation of the modern Pakistan batting is laid on Babar and Mohammad Rizwan playing cautious early on, getting to around 30 in the first 5 overs and trying to keep wickets in hand for a vast majority of the team’s quota of overs.<br><br></div><div>More often than not, they leave just enough overs for the later batters to get a quick 50-60. That cautious early and carefree later approach is being used only by Pakistan among the top teams, none of whom let the run rate drop even when wickets are tumbling.<br><br></div><div>The notion that attack is the best form of defence, is an approach Pakistan openers do not live by. In this specific match, it was Rizwan who was the culprit for being too slow and laborious.<br><br></div><div>A 49-ball 55 when the job is to get to 171 serves no purpose. It only delays the inevitable. Such has been the performance of the keeper-batter over the past two years that it almost feels wrong to write these sentences but then if you don’t critique and show the mirror, mistakes are almost always repeated in Pakistan cricket.<br><br></div><div>Shadab Khan is another one who should escape without much or any criticism except for a naughty meme or two. The leggie all-rounder was pretty decent throughout — barring the final of course.<br><br></div><div><br></div><div><figure data-trix-attachment='{\"contentType\":\"image\",\"url\":\"https://i.dawn.com/large/2022/09/12141424f98dd4b.jpg\",\"width\":800,\"height\":480}' data-trix-attributes='{\"caption\":\"Shadab Khan\"}'></figure></div><div>Shadab Khan taking a break in the Asia Cup 2022 final between Pakistan and Sri Lanka at the Dubai International Stadium, Dubai, United Arab Emirates, Sept 11. — Reuters</div><div><strong>4. Iftikhar, Khushdil, Asif — same player in 3 different shapes, sizes</strong></div><div>While Rizwan and Khan’s overall body of work makes us show restraint, no such luxuries should be afforded to the likes of Iftikhar, Khushdil Shah and Asif Ali — all three of whom seem to be cut from the same cloth.<br><br></div><div>The trio may come in different shapes and sizes but in reality, they are the same player with just different names and faces.<br><br></div><div>Neither is a proper batter and all three are in the side purely on their six-hitting ability, which is also very hit-and-miss. In fact, it’s more miss than hit — unless you’re up against Hong Kong.<br><br></div><div>Add to them all-rounders Khan and Mohammad Nawaz — who are decent batters but again not specialists — and this Pakistan side’s composition becomes three true batters followed by a series of jacks of all trade masters of none.<br><br></div><div>Mind you, of the three true batters, two are out of form so it was basically Rizwan <a href=\"https://www.dawn.com/news/1708526\">alone versus Asia</a> during this tournament, which is another reason to be gentle with him.<br><br></div>",
  status: 'published',
  published_at: Time.zone.now
)
post1.header_image.attach(io: File.open('app/assets/images/a1.jpeg'), filename: 'a1.jpeg', content_type: 'image/jpeg')
post1.save

post2 = Post.new(
  author: Author.find(author2.id),
  title: 'New PM sends positive signals to China, US',
  description: 'Prime Minister Shehbaz Sharif on Tuesday reiterated the need for cooperation with the United States and India, while assuring Beijing of further deepening of relations.',
  content: '<div><strong>WASHINGTON / ISLAMABAD: Prime Minister Shehbaz Sharif on Tuesday reiterated the need for cooperation with the United States and India, while assuring Beijing of further deepening of relations.<br></strong><br></div><div>“The new government wishes to constructively and positively engage with the US to promote shared goals of peace, security and development in the region,” the Prime Minister’s Office said in response to a White House statement on Mr Sharif taking over as the new prime minister.<br><br></div><div>White House Press Secretary Jen Psaki had earlier said that a democratic Pakistan was critical to US interests.<br><br></div><div>Ties between Islamabad and Washington touched a new low after former prime minister Imran Khan <a href="https://www.dawn.com/news/1683362">accused the US</a> of conspiring to dislodge his government. He based his allegation on a diplomatic cable in which it was reportedly said that a State Department official had warned of consequences for bilateral ties if the no-confidence motion failed.<br><br></div><blockquote><em>Beijing, Moscow send messages; Kashmir solution inevitable, Shehbaz tells Modi<br></em><br></blockquote><div>Washington has denied the allegation.<br><br></div><div>Mending fences with the US would be one of the top foreign policy priorities for the new government.<br><br></div><div>Mr Sharif, while speaking in the National Assembly after his <a href="https://www.dawn.com/news/1684500">election</a>, noted “confusion” in ties and said that it did not mean an end to the historic relationship.<br><br></div><div>The same was repeated in the PM Office statement, which welcomed US reaffirmation of long-standing ties with Pakistan and said that the new government looked forward to deepening this “important relationship” on the principles of equality, mutual interest and mutual benefit.<br><br></div><div><strong>Messages from other leaders<br></strong><br></div><div>Meanwhile, in response to a congratulatory tweet by Indian Prime Minister Narendra Modi, Mr Sharif called for securing peace and focusing on socio-economic development of the people.<br><br></div><div>“Pakistan desires peaceful &amp; cooperative ties with India. Peaceful settlement of outstanding disputes, including Jammu &amp; Kashmir, is indispensable,” he further said.<br><br></div><div><br></div><div><br></div><div>Talking to the Charge d’ Affaires of People’s Republic of China, Ms Pang Chunxue, who called on him, PM Sharif affirmed his government’s commitment to further deepening the win-win economic cooperative partnership between the two countries.<br><br></div><div><br></div><div><br></div><div>He expressed his government’s resolve to speed up high quality development of CPEC projects and make it a symbol of China-Pakistan friendship and close partnership. He, moreover, underlined the importance of enhanced investment from China in industrialization, agriculture, and digital technologies.<br><br></div><div>Russian President Vladimir Putin also greeted Mr Sharif. According to a statement by Russia’s embassy in Pakistan, hoped that the new government will “contribute to further development of the Pakistan-Russia cooperation and partner interaction on the Afghan settlement as well as countering international terrorism.”<br><br></div><div><strong>US approach<br></strong><br></div><div>At the Monday afternoon news briefing in Washington, a journalist asked White House Press Secretary Jen Psaki what was the administration’s reaction to the new developments in Pakistan. “Does President Biden plan to speak with the country’s new prime minister?”<br><br></div><div>Responding to the first part of the question, Ms Psaki said the United States “support(s) the peaceful upholding of constitutional democratic principles. We don’t support one political party over another, and we certainly support the principles of rule of law and equal justice under the law.”<br><br></div><div>Recalling that the United States and Pakistan were old allies, she said: “We value our long standing cooperation with Pakistan, and have always viewed a prosperous and democratic Pakistan as critical to US interests. That remains unchanged, regardless of who leadership is.”<br><br></div><div>Responding to the question about President Biden calling the new prime minister, she said she did not “have anything to predict at this point in time. Obviously, we stay in close touch with them at a range of levels.”<br><br></div><div>A third journalist tried a different approach and asked to get more information from the White House Press Secretary on Mr Biden’s call. “What arrangements does the administration have to contact him (Mr Sharif) and what’s moving forward on that?” he asked.<br><br></div><div>“I don’t have a prediction of a call at this point in time. Obviously, those are assessments made day by day, especially after new leaders are elected,” Ms Psaki said.<br><br></div><div>“We have a long, strong, and abiding relationship with Pakistan, an important security relationship, and that will continue under new leaders,” she added.<br><br></div>',
  status: 'published',
  published_at: Time.zone.now
)
post2.header_image.attach(io: File.open('app/assets/images/a2.jpeg'), filename: 'a2.jpeg', content_type: 'image/jpeg')
post2.save
# COMMENTS
Comment.create!([{
                  post: post1,
                  author: author2,
                  content: 'This is a seeded comment',
                  parent_id: nil
                },
                 {
                   post: post2,
                   author: author1,
                   content: 'This is a seeded comment.',
                   parent_id: nil
                 },
                 {
                   post: post2,
                   author: author2,
                   content: 'This is a seeded comment',
                   parent_id: nil
                 }])
