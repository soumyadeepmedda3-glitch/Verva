-- Verva - Seed Data
-- Generated automatically from conversation-data.json
-- Run after schema.sql

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE conversation_lines;
TRUNCATE TABLE conversation_sets;
TRUNCATE TABLE topics;
SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------
-- Topics
-- ---------------------------------------------------------------
INSERT INTO topics (topic_key, name, description) VALUES
('daily-conversation', 'Daily Conversation', 'Everyday small talk and greetings'),
('morning-routine', 'Morning Routine', 'Talking about waking up and starting the day'),
('college', 'College', 'Conversations about college life and classes'),
('school', 'School', 'Conversations about school life'),
('shopping', 'Shopping', 'Buying things at a store or mall'),
('restaurant', 'Restaurant', 'Ordering food and dining out'),
('travel', 'Travel', 'Talking about trips and journeys'),
('hotel', 'Hotel', 'Checking in and staying at a hotel'),
('airport', 'Airport', 'Checking in, security, and boarding flights'),
('meeting-someone', 'Meeting Someone', 'Introducing yourself to new people'),
('job-interview', 'Job Interview', 'Answering common interview questions'),
('office', 'Office', 'Workplace conversations'),
('friends', 'Friends', 'Casual talk with friends'),
('at-home', 'At Home', 'Everyday conversations at home'),
('asking-directions', 'Asking for Directions', 'Finding your way around a city'),
('doctor-visit', 'Doctor Visit', 'Talking with a doctor about health'),
('future-plans', 'Future Plans', 'Talking about upcoming plans'),
('past-experiences', 'Past Experiences', 'Talking about things that already happened'),
('weekend-conversation', 'Weekend Conversation', 'Talking about the weekend');

-- ---------------------------------------------------------------
-- Conversation Sets & Lines
-- ---------------------------------------------------------------

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'daily-conversation';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hi there! How are you today?', 'I\'m fine, thank you. How about you?'),
(@set_id, 2, 'I\'m good too, thanks. What is your name?', 'My name is Sam. Nice to meet you.'),
(@set_id, 3, 'Nice to meet you too. Where are you from?', 'I\'m from India.'),
(@set_id, 4, 'That\'s great. What do you do?', 'I\'m a student.'),
(@set_id, 5, 'How is the weather today?', 'It\'s sunny and warm today.'),
(@set_id, 6, 'Do you like coffee or tea?', 'I like tea more than coffee.'),
(@set_id, 7, 'What did you have for breakfast?', 'I had toast and eggs.'),
(@set_id, 8, 'It was nice talking to you. Have a great day!', 'Thank you, you too!'),
(@set_id, 9, 'Do you have any brothers or sisters?', 'Yes, I have one brother.'),
(@set_id, 10, 'What is your favorite color?', 'My favorite color is blue.'),
(@set_id, 11, 'Do you like music?', 'Yes, I love listening to music.'),
(@set_id, 12, 'What time do you usually sleep?', 'I usually sleep at eleven.'),
(@set_id, 13, 'Can you cook?', 'Yes, I can cook simple food.'),
(@set_id, 14, 'Do you have a pet?', 'Yes, I have a small dog.'),
(@set_id, 15, 'What is your favorite season?', 'I like winter the most.'),
(@set_id, 16, 'Do you play any sports?', 'Yes, I play badminton sometimes.'),
(@set_id, 17, 'How do you usually spend your evenings?', 'I usually watch TV or read a book.'),
(@set_id, 18, 'Do you like spicy food?', 'Yes, I really enjoy spicy food.'),
(@set_id, 19, 'What languages do you speak?', 'I speak English and Bengali.'),
(@set_id, 20, 'It was nice talking with you today.', 'Yes, I enjoyed our conversation too.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'daily-conversation';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hey! Long time no see. How have you been?', 'I\'ve been pretty good, just busy with work.'),
(@set_id, 2, 'I heard you moved to a new place. How is it?', 'It\'s nice, but I\'m still getting used to the neighborhood.'),
(@set_id, 3, 'What have you been up to lately?', 'Not much, just the usual routine and a few hobbies.'),
(@set_id, 4, 'Have you tried the new cafe downtown?', 'Not yet, but I\'ve heard great things about it.'),
(@set_id, 5, 'How is your family doing these days?', 'They\'re doing well, thanks for asking.'),
(@set_id, 6, 'Do you have any plans for the evening?', 'I\'m thinking of relaxing at home tonight.'),
(@set_id, 7, 'What\'s something interesting that happened to you this week?', 'I ran into an old friend at the grocery store.'),
(@set_id, 8, 'It was great catching up with you.', 'Same here, let\'s do this again soon.'),
(@set_id, 9, 'What\'s something you\'re looking forward to this month?', 'I\'m looking forward to a short trip with my family.'),
(@set_id, 10, 'Do you usually keep in touch with old friends?', 'I try to, though it\'s harder now that everyone\'s busy.'),
(@set_id, 11, 'How do you usually spend your free time?', 'I like reading, and sometimes I go for long walks.'),
(@set_id, 12, 'What\'s a small thing that made you happy recently?', 'Honestly, a good cup of coffee this morning made my day.'),
(@set_id, 13, 'Do you prefer texting or calling people?', 'I prefer texting, it feels less intrusive most of the time.'),
(@set_id, 14, 'What\'s your go-to comfort food?', 'Definitely a warm bowl of soup on a rainy day.'),
(@set_id, 15, 'How was your week overall?', 'Pretty busy, but a few good things happened too.'),
(@set_id, 16, 'Do you enjoy trying new restaurants?', 'Yes, I love discovering new places to eat around the city.'),
(@set_id, 17, 'What\'s a habit you\'re trying to build right now?', 'I\'m trying to read a little every night before bed.'),
(@set_id, 18, 'Do you follow any sports regularly?', 'Not really, but I do enjoy watching the occasional big match.'),
(@set_id, 19, 'What kind of music do you usually listen to?', 'Mostly indie and acoustic music, it helps me relax.'),
(@set_id, 20, 'This chat was a nice little break from work.', 'Same here, thanks for the good conversation.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'daily-conversation';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'It\'s been a while. What\'s new in your world?', 'Quite a lot, actually. I\'ve been juggling a new project and some personal changes.'),
(@set_id, 2, 'I noticed you seem a bit more relaxed lately. Any particular reason?', 'I\'ve started prioritizing my time better, so things feel less overwhelming.'),
(@set_id, 3, 'What are your thoughts on how fast everything is changing these days?', 'Honestly, it\'s a mixed bag; exciting but also a bit exhausting to keep up with.'),
(@set_id, 4, 'Do you think people rely too much on technology for communication?', 'To some extent, yes, though it does help us stay connected across distances.'),
(@set_id, 5, 'How do you usually unwind after a demanding day?', 'I like to take a long walk or read something unrelated to work.'),
(@set_id, 6, 'What\'s a small habit that has made a big difference in your life?', 'Writing down three things I\'m grateful for each night has really helped my mood.'),
(@set_id, 7, 'Any book or podcast you\'d recommend recently?', 'I\'ve been enjoying a podcast about behavioral psychology, it\'s quite insightful.'),
(@set_id, 8, 'This conversation really got me thinking. Thanks for sharing.', 'Likewise, I always enjoy these kinds of chats with you.'),
(@set_id, 9, 'Do you think people are more connected or more isolated because of social media?', 'Honestly, I think it\'s both — connected superficially but isolated in deeper ways.'),
(@set_id, 10, 'What\'s a belief you held strongly a few years ago that\'s changed since?', 'I used to think busyness equaled productivity, and I\'ve completely rethought that.'),
(@set_id, 11, 'How do you personally define a successful week?', 'For me, it\'s less about output and more about staying reasonably balanced.'),
(@set_id, 12, 'Do you think it\'s important to be good at small talk?', 'To some extent, yes, it often opens the door to deeper conversations.'),
(@set_id, 13, 'What\'s something you\'ve become more patient about with age?', 'Definitely other people\'s pace, I used to get frustrated much more easily.'),
(@set_id, 14, 'How do you usually recharge after a socially draining day?', 'I need quiet time alone, even just twenty minutes makes a difference.'),
(@set_id, 15, 'Do you think honesty is always the best policy in conversations?', 'Mostly, though I think tact matters just as much as honesty itself.'),
(@set_id, 16, 'What\'s a subject you could talk about for hours?', 'Probably behavioral psychology, I find human decision-making endlessly fascinating.'),
(@set_id, 17, 'How do you approach conversations with people who disagree with you?', 'I try to genuinely understand their reasoning before responding with my own.'),
(@set_id, 18, 'Do you think we\'re generally too quick to judge people we just met?', 'Absolutely, first impressions are useful but often unfairly permanent in our minds.'),
(@set_id, 19, 'What\'s a small kindness someone showed you that you still remember?', 'A stranger once helped me carry groceries up five flights of stairs.'),
(@set_id, 20, 'This has genuinely been a thought-provoking conversation.', 'I agree, it\'s rare to get this reflective in casual conversation.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'morning-routine';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Good morning! What time did you wake up?', 'I woke up at seven o\'clock.'),
(@set_id, 2, 'Do you exercise in the morning?', 'Yes, I go for a short walk.'),
(@set_id, 3, 'What do you eat for breakfast?', 'I usually eat cereal and fruit.'),
(@set_id, 4, 'Do you drink coffee in the morning?', 'Yes, I drink one cup of coffee.'),
(@set_id, 5, 'What time do you leave for work or school?', 'I leave at eight thirty.'),
(@set_id, 6, 'Do you check your phone first thing in the morning?', 'Yes, I check messages and the news.'),
(@set_id, 7, 'How do you feel in the mornings?', 'I feel a bit sleepy but okay after coffee.'),
(@set_id, 8, 'Have a good day at work!', 'Thank you, you too!'),
(@set_id, 9, 'Do you make your bed every morning?', 'Yes, I make my bed every day.'),
(@set_id, 10, 'Do you take a shower in the morning?', 'Yes, I take a shower every morning.'),
(@set_id, 11, 'What do you wear to work or school?', 'I wear a shirt and trousers.'),
(@set_id, 12, 'Do you brush your teeth before or after breakfast?', 'I brush my teeth after breakfast.'),
(@set_id, 13, 'How long does your morning routine take?', 'It takes about one hour.'),
(@set_id, 14, 'Do you read the news in the morning?', 'Yes, I read the news on my phone.'),
(@set_id, 15, 'Is it easy for you to wake up?', 'No, it is a little difficult for me.'),
(@set_id, 16, 'Do you use an alarm clock?', 'Yes, I use my phone as an alarm.'),
(@set_id, 17, 'Do you eat breakfast at home or outside?', 'I always eat breakfast at home.'),
(@set_id, 18, 'What do you do first after waking up?', 'I drink a glass of water first.'),
(@set_id, 19, 'Do you feel fresh in the morning?', 'Yes, I usually feel fresh and ready.'),
(@set_id, 20, 'Thanks for sharing your morning routine!', 'You\'re welcome, thanks for asking.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'morning-routine';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'What does your typical morning routine look like?', 'I usually wake up early, stretch a little, and then make breakfast.'),
(@set_id, 2, 'Do you prefer waking up early or sleeping in?', 'I prefer waking up early because I get more done.'),
(@set_id, 3, 'How do you prepare for a busy day ahead?', 'I plan my tasks the night before so my morning feels less rushed.'),
(@set_id, 4, 'Do you have any morning habits that keep you energized?', 'Drinking a glass of water and doing a quick workout really helps.'),
(@set_id, 5, 'What\'s the hardest part of your morning?', 'Getting out of bed when it\'s cold is always the hardest part.'),
(@set_id, 6, 'Do you eat breakfast at home or on the way?', 'I usually eat at home so I\'m not rushing later.'),
(@set_id, 7, 'How do mornings affect the rest of your day?', 'A calm morning usually means I stay more focused throughout the day.'),
(@set_id, 8, 'Sounds like you have a solid routine!', 'Thanks, it took a while to build, but it works well for me now.'),
(@set_id, 9, 'Do you follow the same morning routine every single day?', 'Mostly, though weekends are a bit more relaxed and flexible.'),
(@set_id, 10, 'What\'s the first thing you check on your phone?', 'Usually the weather, so I know how to dress for the day.'),
(@set_id, 11, 'Do you prefer a quiet morning or listening to music while getting ready?', 'I actually prefer quiet, it helps me think clearly before the day starts.'),
(@set_id, 12, 'How do you make sure you\'re not rushing in the morning?', 'I lay out my clothes and pack my bag the night before.'),
(@set_id, 13, 'Do you exercise before or after breakfast?', 'Before breakfast, I feel more energetic working out on an empty stomach.'),
(@set_id, 14, 'What\'s something that instantly ruins your morning?', 'Running late for the bus completely throws off my whole mood.'),
(@set_id, 15, 'Do you ever skip breakfast when you\'re in a hurry?', 'Occasionally, though I try to at least grab some fruit.'),
(@set_id, 16, 'How do you transition from home mode to work mode?', 'The commute usually helps me mentally shift into work mode.'),
(@set_id, 17, 'Do you think a good morning really affects your whole day?', 'Definitely, a calm start usually keeps me steady even during stressful moments.'),
(@set_id, 18, 'What\'s one thing you\'d like to add to your morning routine?', 'I\'d like to start journaling for a few minutes each morning.'),
(@set_id, 19, 'Do you check your work emails first thing in the morning?', 'I try not to, it tends to spike my stress too early.'),
(@set_id, 20, 'Thanks for walking me through your mornings.', 'No problem, it was fun thinking it through out loud.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'morning-routine';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'How has your morning routine evolved over the years?', 'It used to be chaotic, but now I\'ve structured it around a few key priorities.'),
(@set_id, 2, 'Do you think a consistent morning routine really impacts productivity?', 'Definitely, starting the day with intention sets the tone for everything after.'),
(@set_id, 3, 'What\'s one change to your mornings that made the biggest difference?', 'Cutting out screen time for the first thirty minutes changed everything for me.'),
(@set_id, 4, 'How do you balance routine with flexibility on hectic days?', 'I try to keep a few non-negotiables and let the rest adapt as needed.'),
(@set_id, 5, 'Do you think early mornings are overrated as a productivity hack?', 'Somewhat, I think it matters less when you wake up and more what you do after.'),
(@set_id, 6, 'What role does mindset play in how your mornings go?', 'A huge role; if I start anxious, that mood tends to follow me all day.'),
(@set_id, 7, 'Any advice for someone trying to build a better morning routine?', 'Start small, maybe just one new habit, and build from there gradually.'),
(@set_id, 8, 'This was a great discussion on mornings.', 'Agreed, it\'s a small part of the day that shapes a lot.'),
(@set_id, 9, 'Do you think morning routines are more about discipline or environment design?', 'Mostly environment design; removing friction matters more than sheer willpower.'),
(@set_id, 10, 'How do you handle mornings after a poor night\'s sleep?', 'I lower my expectations for the day and focus only on essentials.'),
(@set_id, 11, 'Do you think the \'wake up at 5am\' productivity trend is overhyped?', 'Largely, yes — consistency matters far more than the specific wake-up hour.'),
(@set_id, 12, 'What role does your environment play in how smoothly your morning goes?', 'A huge role; a tidy space the night before saves real mental energy.'),
(@set_id, 13, 'How do you protect your morning routine when life gets chaotic?', 'I hold onto just one non-negotiable habit and let everything else flex.'),
(@set_id, 14, 'Do you think screens should be avoided entirely in the morning?', 'Not entirely, but delaying them even briefly does seem to help focus.'),
(@set_id, 15, 'What\'s the psychological effect of accomplishing something small right after waking up?', 'It creates early momentum that tends to carry into bigger tasks later.'),
(@set_id, 16, 'How do you personally define a \'successful\' morning?', 'One where I feel unhurried, regardless of how much actually got done.'),
(@set_id, 17, 'Do you think morning routines should be identical every day?', 'No, I think some flexibility actually makes them more sustainable long-term.'),
(@set_id, 18, 'What\'s a morning habit you eventually gave up on, and why?', 'Cold showers — the discomfort outweighed any real benefit for me personally.'),
(@set_id, 19, 'How do mornings differ for you on weekends versus weekdays?', 'Weekends are slower and less structured, which I find genuinely restorative.'),
(@set_id, 20, 'This was a surprisingly deep dive into something so routine.', 'It really was, mornings shape more of our lives than we usually notice.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'college';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hi! What are you studying in college?', 'I\'m studying computer science.'),
(@set_id, 2, 'Do you like your classes this semester?', 'Yes, most of them are interesting.'),
(@set_id, 3, 'How many classes do you have today?', 'I have three classes today.'),
(@set_id, 4, 'Do you live on campus or at home?', 'I live on campus in a dorm.'),
(@set_id, 5, 'What is your favorite subject?', 'My favorite subject is mathematics.'),
(@set_id, 6, 'Do you have a lot of homework this week?', 'Yes, I have an assignment due on Friday.'),
(@set_id, 7, 'Are you part of any clubs?', 'Yes, I\'m in the photography club.'),
(@set_id, 8, 'Good luck with your studies!', 'Thank you, I appreciate it.'),
(@set_id, 9, 'Which year are you in college?', 'I am in my second year.'),
(@set_id, 10, 'Do you take the bus to college?', 'Yes, I take the bus every day.'),
(@set_id, 11, 'How many students are in your class?', 'There are about forty students.'),
(@set_id, 12, 'Do you like your college campus?', 'Yes, the campus is very nice.'),
(@set_id, 13, 'Do you have a favorite teacher?', 'Yes, my math teacher is my favorite.'),
(@set_id, 14, 'Do you eat at the college canteen?', 'Yes, I eat there most days.'),
(@set_id, 15, 'Do you study in a group or alone?', 'I usually study alone at home.'),
(@set_id, 16, 'What time do your classes start?', 'My classes start at nine in the morning.'),
(@set_id, 17, 'Do you use a laptop for your studies?', 'Yes, I use my laptop every day.'),
(@set_id, 18, 'Are your exams difficult this semester?', 'Yes, they are a bit difficult.'),
(@set_id, 19, 'Do you play sports at college?', 'Yes, I play football on weekends.'),
(@set_id, 20, 'Good luck with your next class!', 'Thank you, I\'ll do my best.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'college';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'How are you finding college life so far?', 'It\'s been challenging but really rewarding overall.'),
(@set_id, 2, 'What made you choose your major?', 'I\'ve always been curious about how technology solves real problems.'),
(@set_id, 3, 'How do you manage your time between classes and social life?', 'I try to plan my week ahead so I don\'t fall behind on either.'),
(@set_id, 4, 'Do you have any group projects going on right now?', 'Yes, we\'re working on a presentation due next week.'),
(@set_id, 5, 'What\'s the biggest difference between school and college for you?', 'College requires a lot more independent study and self-discipline.'),
(@set_id, 6, 'Are you thinking about internships for next summer?', 'Yes, I\'m planning to apply to a few companies soon.'),
(@set_id, 7, 'How do you usually prepare for exams?', 'I make summary notes and review them a few days before the test.'),
(@set_id, 8, 'It sounds like you\'re managing things well.', 'Thanks, it\'s definitely a learning process.'),
(@set_id, 9, 'How do you usually balance assignments from multiple classes?', 'I make a simple weekly schedule so nothing sneaks up on me.'),
(@set_id, 10, 'What\'s a class you\'re currently enjoying the most?', 'My economics class, the professor makes even dry topics interesting.'),
(@set_id, 11, 'Do you attend office hours when you\'re struggling with a topic?', 'Yes, I\'ve found that a few minutes with the professor saves hours of confusion.'),
(@set_id, 12, 'How do you usually pick your elective courses?', 'I try to choose ones that genuinely interest me, not just easy grades.'),
(@set_id, 13, 'What\'s the most useful skill college has taught you so far?', 'Honestly, just learning how to manage my own time effectively.'),
(@set_id, 14, 'Do you work a part-time job alongside your studies?', 'Yes, I tutor high school students a few hours a week.'),
(@set_id, 15, 'How do you deal with group projects when teammates aren\'t contributing?', 'I try to communicate early and redistribute tasks before it becomes a bigger issue.'),
(@set_id, 16, 'What\'s your study environment like — library or dorm room?', 'The library, honestly, my dorm has way too many distractions.'),
(@set_id, 17, 'Do you think college has changed the way you see the world?', 'Definitely, exposure to different viewpoints has broadened my thinking a lot.'),
(@set_id, 18, 'How do you recover after a particularly stressful exam week?', 'I usually take a full day off and do absolutely nothing academic.'),
(@set_id, 19, 'Are you considering graduate school after this?', 'I\'m leaning toward it, though I want some work experience first.'),
(@set_id, 20, 'It sounds like you\'re getting a lot out of college.', 'I really am, even the tough parts have taught me something.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'college';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'What\'s been the most valuable lesson you\'ve learned in college so far?', 'Probably that grades matter less than genuinely understanding the material.'),
(@set_id, 2, 'Do you think the traditional college model still prepares students well for the job market?', 'Partly; it builds a foundation, but practical skills often come from outside the classroom.'),
(@set_id, 3, 'How do you handle the pressure of competing priorities like academics and extracurriculars?', 'I set clear priorities each week and accept that I can\'t do everything perfectly.'),
(@set_id, 4, 'What\'s a class that completely changed how you think?', 'A philosophy elective pushed me to question assumptions I never even noticed I had.'),
(@set_id, 5, 'Do you think networking is as important as academic performance?', 'I\'d say they\'re both important, but networking often opens doors grades alone can\'t.'),
(@set_id, 6, 'How do you deal with burnout during exam season?', 'I schedule short breaks and try not to feel guilty about resting.'),
(@set_id, 7, 'What advice would you give to an incoming freshman?', 'Don\'t be afraid to ask for help early instead of struggling silently.'),
(@set_id, 8, 'This was a thoughtful conversation about college life.', 'Thanks, it\'s nice to reflect on it out loud sometimes.'),
(@set_id, 9, 'Do you think the value of a college degree has changed in recent years?', 'It has shifted — I think the network and experience now matter as much as the degree itself.'),
(@set_id, 10, 'How do you decide which opportunities are worth pursuing amid so many options?', 'I try to filter by long-term relevance rather than short-term prestige.'),
(@set_id, 11, 'What\'s a misconception incoming students often have about college?', 'That grades alone determine success — soft skills often matter just as much.'),
(@set_id, 12, 'How has mentorship shaped your college experience?', 'Enormously; a professor\'s early encouragement changed my entire academic direction.'),
(@set_id, 13, 'Do you think competitive environments help or hinder genuine learning?', 'It depends — mild competition motivates, but excessive competition breeds anxiety instead.'),
(@set_id, 14, 'What\'s your approach to balancing idealism with practicality in choosing a career path?', 'I try to find overlap between what I care about and what\'s actually sustainable.'),
(@set_id, 15, 'How do you evaluate whether a professor\'s teaching style works for you?', 'I pay attention to whether I retain the material weeks later, not just during lectures.'),
(@set_id, 16, 'Do you think college adequately prepares students for ambiguity in the real world?', 'Not entirely — structured assignments rarely mirror the messiness of actual problems.'),
(@set_id, 17, 'What\'s something you wish someone had told you before starting college?', 'That it\'s fine to change your major — clarity often comes through exploration, not before it.'),
(@set_id, 18, 'How do you maintain intellectual curiosity outside your required coursework?', 'I set aside time to read completely unrelated subjects, just for the joy of it.'),
(@set_id, 19, 'Do you think the pressure to network can feel transactional to some students?', 'Definitely, though I\'ve found genuine curiosity about people avoids that feeling entirely.'),
(@set_id, 20, 'This conversation captured a lot of the real complexity of college life.', 'It did, it\'s rarely as linear as it looks from the outside.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'school';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hi! What grade are you in?', 'I\'m in the ninth grade.'),
(@set_id, 2, 'What is your favorite subject at school?', 'My favorite subject is science.'),
(@set_id, 3, 'Do you like your teacher?', 'Yes, my teacher is very kind.'),
(@set_id, 4, 'What time does school start?', 'School starts at eight o\'clock.'),
(@set_id, 5, 'Do you play any sports at school?', 'Yes, I play basketball after school.'),
(@set_id, 6, 'How do you go to school every day?', 'I go to school by bus.'),
(@set_id, 7, 'Do you have a lot of friends at school?', 'Yes, I have many good friends.'),
(@set_id, 8, 'Have a great day at school!', 'Thank you, see you later!'),
(@set_id, 9, 'What time does school end for you?', 'School ends at three o\'clock.'),
(@set_id, 10, 'Do you walk to school or take a bus?', 'I take a bus to school.'),
(@set_id, 11, 'Do you wear a school uniform?', 'Yes, we wear a uniform every day.'),
(@set_id, 12, 'What is your favorite class of the day?', 'My favorite class is art.'),
(@set_id, 13, 'Do you have a school library?', 'Yes, we have a big library.'),
(@set_id, 14, 'Do you eat lunch at school?', 'Yes, I eat lunch in the canteen.'),
(@set_id, 15, 'Do you have homework every day?', 'Yes, I have homework almost every day.'),
(@set_id, 16, 'Who is your best friend at school?', 'My best friend is named Riya.'),
(@set_id, 17, 'Do you like your school bag?', 'Yes, it is my favorite color.'),
(@set_id, 18, 'Is your school big or small?', 'My school is quite big.'),
(@set_id, 19, 'Do you enjoy physical education class?', 'Yes, I really enjoy P.E. class.'),
(@set_id, 20, 'Have a good rest of your school day!', 'Thank you, you too!');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'school';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'What subjects are you focusing on this year?', 'I\'m mainly focusing on math and English this year.'),
(@set_id, 2, 'Do you have any exams coming up soon?', 'Yes, I have a science exam next Monday.'),
(@set_id, 3, 'How do you usually study for tests?', 'I review my notes and do practice questions.'),
(@set_id, 4, 'Are you involved in any school activities?', 'Yes, I\'m part of the debate team.'),
(@set_id, 5, 'What do you like most about your school?', 'I like that the teachers are supportive and approachable.'),
(@set_id, 6, 'Is there a subject you find difficult?', 'Chemistry is a bit difficult for me, but I\'m improving.'),
(@set_id, 7, 'Do you get much homework each night?', 'Usually around an hour or two, depending on the day.'),
(@set_id, 8, 'Sounds like you\'re doing well at school.', 'Thanks, I\'m trying my best this year.'),
(@set_id, 9, 'What\'s a school project you\'re proud of?', 'A science fair project on renewable energy that won second place.'),
(@set_id, 10, 'How do you usually prepare the night before a big test?', 'I review my notes early and try to sleep on time instead of cramming.'),
(@set_id, 11, 'Do you participate in any after-school clubs?', 'Yes, I\'m part of the school newspaper club.'),
(@set_id, 12, 'What\'s the hardest subject for you this year?', 'Physics, the concepts take me longer to fully understand.'),
(@set_id, 13, 'How do your teachers usually handle students who fall behind?', 'Most offer extra help sessions if you ask before it gets too far behind.'),
(@set_id, 14, 'Do you think school pressures students too much about grades?', 'Sometimes, though I understand why grades matter for future opportunities.'),
(@set_id, 15, 'What\'s something outside academics that school has taught you?', 'Definitely teamwork, group projects taught me a lot about compromise.'),
(@set_id, 16, 'How do you balance schoolwork with hobbies?', 'I schedule specific hours for hobbies so they don\'t get pushed aside.'),
(@set_id, 17, 'Do you have a subject you\'re naturally good at?', 'Yes, English comes fairly easily to me compared to other subjects.'),
(@set_id, 18, 'What motivates you to keep working hard at school?', 'Mostly wanting more options when it comes time to choose a career.'),
(@set_id, 19, 'How do you handle disagreements with classmates during group work?', 'I try to listen first and find a middle ground everyone can accept.'),
(@set_id, 20, 'You seem really thoughtful about your school experience.', 'Thanks, I try to take it seriously without stressing too much.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'school';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'How do you think school could better prepare students for real life?', 'I think more practical skills, like managing money, should be part of the curriculum.'),
(@set_id, 2, 'What\'s a teacher or lesson that really shaped how you think?', 'My history teacher taught us to question sources instead of accepting them blindly.'),
(@set_id, 3, 'Do you feel a lot of pressure around grades?', 'Sometimes, but I\'ve learned to focus more on understanding than just scores.'),
(@set_id, 4, 'How do you balance schoolwork with your personal interests?', 'I set aside specific time for hobbies so schoolwork doesn\'t take over completely.'),
(@set_id, 5, 'What\'s your opinion on standardized testing?', 'I think it measures a narrow set of skills and misses a lot of what students can do.'),
(@set_id, 6, 'How do you support classmates who are struggling?', 'I try to explain things in a simpler way or study together with them.'),
(@set_id, 7, 'What are you hoping to do after finishing school?', 'I\'m considering a few paths, but I\'m leaning toward studying engineering.'),
(@set_id, 8, 'That\'s a mature way to look at your education.', 'Thank you, I\'ve had time to think about it a lot.'),
(@set_id, 9, 'Do you think the current grading system accurately reflects student ability?', 'Not entirely — it measures test performance more than genuine understanding or growth.'),
(@set_id, 10, 'How do you personally cope with academic comparison among classmates?', 'I try to focus on my own progress rather than measuring myself against others.'),
(@set_id, 11, 'What\'s a systemic issue in education you feel strongly about?', 'The lack of emphasis on critical thinking over rote memorization concerns me most.'),
(@set_id, 12, 'How has a specific teacher influenced your worldview beyond their subject?', 'My literature teacher taught me to question narratives, not just analyze them.'),
(@set_id, 13, 'Do you think extracurricular involvement should weigh as heavily as academics?', 'I think it should, since it often develops skills grades simply don\'t capture.'),
(@set_id, 14, 'What\'s your view on standardized curricula versus more personalized learning paths?', 'Personalized paths seem more effective, though standardization does ensure baseline consistency.'),
(@set_id, 15, 'How do you manage the tension between intrinsic curiosity and extrinsic grade pressure?', 'I try to reframe assignments around what genuinely interests me within the topic.'),
(@set_id, 16, 'Do you think schools adequately prepare students emotionally, not just academically?', 'Rarely — emotional resilience is assumed rather than actively taught in most schools.'),
(@set_id, 17, 'What\'s an unconventional way you\'ve found to stay motivated in tough subjects?', 'I connect the material to real-world problems I actually care about solving.'),
(@set_id, 18, 'How do you evaluate whether advice from teachers or mentors is actually useful?', 'I weigh it against outcomes I\'ve seen, not just the authority of who gave it.'),
(@set_id, 19, 'Do you think competition among students helps or damages collaboration long-term?', 'Excessive competition often damages it — cooperative environments tend to produce deeper learning.'),
(@set_id, 20, 'This has been a genuinely reflective conversation about education.', 'It has, school shapes so much more than just what\'s on a report card.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'shopping';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hello! Welcome to our store. Can I help you?', 'Yes, I\'m looking for a jacket.'),
(@set_id, 2, 'What size do you need?', 'I need a medium size, please.'),
(@set_id, 3, 'Here is a nice jacket. Do you like the color?', 'Yes, I like the blue one.'),
(@set_id, 4, 'Would you like to try it on?', 'Yes, where is the fitting room?'),
(@set_id, 5, 'How does it fit?', 'It fits well, I\'ll take it.'),
(@set_id, 6, 'Would you like anything else?', 'No, that\'s all for today, thank you.'),
(@set_id, 7, 'How would you like to pay?', 'I\'ll pay by card, please.'),
(@set_id, 8, 'Thank you for shopping with us!', 'Thank you, have a nice day!'),
(@set_id, 9, 'Do you like shopping for clothes?', 'Yes, I enjoy shopping for clothes.'),
(@set_id, 10, 'Do you prefer shopping online or in stores?', 'I prefer shopping in stores.'),
(@set_id, 11, 'What size shoes do you wear?', 'I wear size eight shoes.'),
(@set_id, 12, 'Is this shirt available in other colors?', 'Yes, it comes in red and black too.'),
(@set_id, 13, 'How much does this cost?', 'It costs twenty dollars.'),
(@set_id, 14, 'Do you have a smaller size?', 'Yes, let me check for you.'),
(@set_id, 15, 'Can I return this if it doesn\'t fit?', 'Yes, you can return it within a week.'),
(@set_id, 16, 'Do you accept cash payments?', 'Yes, we accept both cash and card.'),
(@set_id, 17, 'Where is the checkout counter?', 'It\'s right over there, near the entrance.'),
(@set_id, 18, 'Do you have a shopping bag I can use?', 'Yes, here is a bag for you.'),
(@set_id, 19, 'Is there a sale going on today?', 'Yes, everything is twenty percent off.'),
(@set_id, 20, 'Thank you for shopping with us!', 'Thank you, have a great day!');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'shopping';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Are you looking for something specific today?', 'Yes, I\'m searching for a gift for my friend\'s birthday.'),
(@set_id, 2, 'What kind of things does your friend like?', 'She really enjoys reading and cozy home decor.'),
(@set_id, 3, 'We have a nice collection of books and candles over there.', 'That sounds perfect, let me take a look.'),
(@set_id, 4, 'Would you like this gift wrapped?', 'Yes, that would be great, thank you.'),
(@set_id, 5, 'Do you have a store membership card?', 'No, I don\'t, but I\'d like to sign up if it\'s easy.'),
(@set_id, 6, 'It just takes a minute to fill out this form.', 'Sure, I don\'t mind, go ahead.'),
(@set_id, 7, 'Is there a discount on this item this week?', 'Yes, actually, it\'s fifteen percent off until Sunday.'),
(@set_id, 8, 'Great, I\'ll take advantage of that. Thanks for your help!', 'You\'re welcome, enjoy your purchase!'),
(@set_id, 9, 'Do you usually make a shopping list before you go?', 'Yes, otherwise I end up buying things I don\'t actually need.'),
(@set_id, 10, 'How do you decide between two similar products?', 'I usually compare reviews and check which one has better durability.'),
(@set_id, 11, 'Do you shop differently during sale seasons?', 'Yes, I try to stock up on things I\'d need anyway when there\'s a discount.'),
(@set_id, 12, 'What\'s something you regret buying on impulse?', 'A pair of shoes that looked great in the store but never fit right.'),
(@set_id, 13, 'Do you prefer small local shops or big retail chains?', 'I try to support local shops when the prices are reasonably close.'),
(@set_id, 14, 'How do you handle it when a product doesn\'t match its description?', 'I usually contact customer service and request a refund or exchange.'),
(@set_id, 15, 'Do you read reviews before making a purchase online?', 'Always, especially for anything above a certain price.'),
(@set_id, 16, 'What\'s your approach to shopping for gifts?', 'I try to think about what the person mentioned wanting recently.'),
(@set_id, 17, 'Do you think loyalty programs are actually worth it?', 'Sometimes, if you shop there often enough to make the points meaningful.'),
(@set_id, 18, 'How do you avoid overspending during big sales?', 'I set a strict budget beforehand and stick to it no matter what.'),
(@set_id, 19, 'Do you enjoy the experience of shopping, or is it just a chore?', 'It depends on the mood — sometimes it\'s relaxing, sometimes it\'s just necessary.'),
(@set_id, 20, 'Thanks for sharing your shopping habits with me.', 'No problem, it\'s interesting to think about actually.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'shopping';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Is there anything I can help you track down today?', 'Actually yes, I\'m trying to find a sustainable brand for everyday clothing.'),
(@set_id, 2, 'We do carry a few eco-friendly lines, would you like details?', 'Please, I\'d love to know what makes them more sustainable.'),
(@set_id, 3, 'They use recycled materials and ethical labor practices throughout production.', 'That\'s reassuring, I try to be mindful of where my money goes.'),
(@set_id, 4, 'Do you usually prioritize sustainability over price when shopping?', 'It depends, but for things I\'ll wear often, I don\'t mind paying a bit more.'),
(@set_id, 5, 'Would you consider secondhand or thrifted items as an alternative?', 'Definitely, I actually find some of my favorite pieces that way.'),
(@set_id, 6, 'What do you think about the rise of online shopping versus in-store?', 'Online is convenient, but I still enjoy trying things on in person sometimes.'),
(@set_id, 7, 'Any tips for shopping on a tighter budget without sacrificing quality?', 'I focus on versatile pieces and wait for seasonal sales instead of impulse buying.'),
(@set_id, 8, 'That\'s great advice. Thanks for chatting with me today.', 'Of course, I enjoyed talking about it.'),
(@set_id, 9, 'Do you think consumer culture has made people less satisfied with what they already own?', 'Largely, yes — constant exposure to new products fuels a sense of perpetual lack.'),
(@set_id, 10, 'How do you personally resist marketing tactics designed to trigger impulse purchases?', 'I give myself a mandatory waiting period before buying anything non-essential.'),
(@set_id, 11, 'What\'s your take on minimalism as a response to overconsumption?', 'I find it appealing in principle, though genuinely practicing it takes real discipline.'),
(@set_id, 12, 'Do you think ethical consumption is realistic within a mass-market economy?', 'Partially — individual choices help, but systemic change matters far more.'),
(@set_id, 13, 'How do you weigh convenience against sustainability when shopping?', 'I try to prioritize sustainability for larger purchases, and accept convenience for smaller ones.'),
(@set_id, 14, 'What\'s a shopping habit you\'ve deliberately unlearned over time?', 'Buying trendy items just to keep up — I\'ve learned that trend chasing rarely satisfies.'),
(@set_id, 15, 'Do you think algorithmic recommendations shape what we think we want?', 'Absolutely, they subtly narrow our exposure while feeling like personalized discovery.'),
(@set_id, 16, 'How do you evaluate whether a purchase reflects a genuine need or manufactured desire?', 'I ask whether I\'d still want it a month from now, without any external influence.'),
(@set_id, 17, 'What\'s your view on secondhand markets as an alternative to fast fashion?', 'I think they\'re an underrated solution — both economically and environmentally sound.'),
(@set_id, 18, 'Do you think price transparency changes how ethically companies behave?', 'To some degree, informed consumers do create pressure companies eventually respond to.'),
(@set_id, 19, 'How has your relationship with material possessions changed as you\'ve gotten older?', 'I value experiences and quality over quantity far more than I used to.'),
(@set_id, 20, 'This turned into a much deeper conversation than I expected about shopping.', 'It really did — consumption says a lot about values, once you dig into it.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'restaurant';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hello! Welcome to our restaurant.', 'Hello. Can I see the menu, please?'),
(@set_id, 2, 'Of course. Here is the menu.', 'Thank you. What do you recommend?'),
(@set_id, 3, 'Our pasta is very popular.', 'That sounds good. I would like to try it.'),
(@set_id, 4, 'Would you like something to drink?', 'Yes, I would like a glass of water.'),
(@set_id, 5, 'Your food will be ready soon.', 'Thank you, I\'m looking forward to it.'),
(@set_id, 6, 'Here is your pasta. Enjoy your meal!', 'Thank you, it looks delicious.'),
(@set_id, 7, 'Would you like a dessert menu?', 'Yes, please, that would be nice.'),
(@set_id, 8, 'Can I get you the bill?', 'Yes, please. Can I pay by card?'),
(@set_id, 9, 'Do you have a reservation for tonight?', 'No, we don\'t have a reservation.'),
(@set_id, 10, 'How many people are in your group?', 'There are four of us.'),
(@set_id, 11, 'Would you like a table inside or outside?', 'Outside would be nice, thank you.'),
(@set_id, 12, 'Are you ready to order?', 'Yes, I would like the chicken curry.'),
(@set_id, 13, 'Would you like rice or bread with that?', 'Rice, please.'),
(@set_id, 14, 'Is the food spicy here?', 'Yes, a little bit spicy.'),
(@set_id, 15, 'Can I get some more water, please?', 'Of course, right away.'),
(@set_id, 16, 'How was your meal today?', 'It was delicious, thank you.'),
(@set_id, 17, 'Would you like to see the dessert menu?', 'No thank you, we are full.'),
(@set_id, 18, 'Do you accept credit cards here?', 'Yes, we accept all major cards.'),
(@set_id, 19, 'Would you like a box for the leftovers?', 'Yes, please, that would be great.'),
(@set_id, 20, 'Please come again soon!', 'Thank you, we definitely will.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'restaurant';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Good evening, do you have a reservation with us?', 'Yes, it\'s under the name Sam, for two people.'),
(@set_id, 2, 'Right this way, here\'s your table by the window.', 'This is lovely, thank you for the great spot.'),
(@set_id, 3, 'Can I start you off with something from the bar?', 'I\'ll just have a sparkling water for now, thanks.'),
(@set_id, 4, 'Are you ready to order, or do you need a few more minutes?', 'We need a couple more minutes to decide, please.'),
(@set_id, 5, 'Take your time. Any dietary restrictions I should know about?', 'Yes, I\'m vegetarian, so I\'ll avoid anything with meat.'),
(@set_id, 6, 'No problem, I\'d recommend our grilled vegetable platter.', 'That sounds great, I\'ll go with that then.'),
(@set_id, 7, 'How was everything tonight?', 'It was excellent, especially the dessert.'),
(@set_id, 8, 'I\'m so glad to hear that. Here\'s your bill whenever you\'re ready.', 'Thank you, dinner was wonderful tonight.'),
(@set_id, 9, 'Would you like to hear about tonight\'s specials?', 'Yes, please, I\'d love to hear what you recommend.'),
(@set_id, 10, 'How spicy would you like your dish prepared?', 'Medium spicy would be perfect, not too mild.'),
(@set_id, 11, 'Do you have any food allergies we should know about?', 'Yes, I\'m allergic to shellfish, so I\'ll avoid that.'),
(@set_id, 12, 'Would you like to start with an appetizer?', 'Yes, we\'ll share the spring rolls to start.'),
(@set_id, 13, 'How would you like your steak cooked?', 'Medium rare, please, that\'s how I like it best.'),
(@set_id, 14, 'Is everything to your liking so far?', 'Yes, everything has been wonderful, thank you for asking.'),
(@set_id, 15, 'Would you like to add any sides to your order?', 'Yes, could we add a side of sautéed vegetables?'),
(@set_id, 16, 'Are you celebrating anything special tonight?', 'Actually yes, it\'s my friend\'s birthday today.'),
(@set_id, 17, 'Would you like us to bring out a small cake?', 'That would be lovely, thank you so much.'),
(@set_id, 18, 'How was the wine pairing with your meal?', 'It complemented the dish really nicely, great recommendation.'),
(@set_id, 19, 'Would you like separate checks or one bill together?', 'One bill together is fine, we\'ll split it ourselves.'),
(@set_id, 20, 'We hope to see you again soon.', 'We\'ll definitely be back, everything was fantastic.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'restaurant';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Welcome back, it\'s been a while since your last visit.', 'It has, I\'ve been meaning to come back and try the new menu.'),
(@set_id, 2, 'We\'ve actually revamped a few dishes based on seasonal ingredients.', 'That\'s exciting, I\'d love to hear what you\'d recommend this time.'),
(@set_id, 3, 'The chef\'s tasting menu pairs really well with a local wine selection.', 'That sounds wonderful, let\'s go with the tasting menu tonight.'),
(@set_id, 4, 'Excellent choice. Any allergies or ingredients you\'d like us to avoid?', 'No allergies, but I\'m not particularly fond of very spicy dishes.'),
(@set_id, 5, 'Noted, I\'ll let the kitchen know to keep things milder for you.', 'I appreciate that, thank you for accommodating the request.'),
(@set_id, 6, 'What did you think of the presentation of each course?', 'Honestly, it was as impressive visually as it was in flavor.'),
(@set_id, 7, 'We\'re glad you enjoyed it. Would you like to hear about our dessert pairings?', 'Absolutely, I\'m curious what you\'d suggest to finish the meal.'),
(@set_id, 8, 'It was a pleasure serving you tonight.', 'The pleasure was ours, we\'ll definitely be back soon.'),
(@set_id, 9, 'Would you be interested in our chef\'s off-menu tasting experience tonight?', 'That sounds intriguing, we\'d love to try something the chef is excited about.'),
(@set_id, 10, 'The dish incorporates a few unconventional ingredients — are you open to that?', 'Absolutely, we\'re here for something a little adventurous tonight.'),
(@set_id, 11, 'How would you describe your ideal balance of flavors in a dish?', 'I gravitate toward something with a bit of acidity to cut through richness.'),
(@set_id, 12, 'Our sommelier suggested a natural wine for this course — interested?', 'Sure, I\'ve been meaning to explore natural wines more seriously.'),
(@set_id, 13, 'Would you like the dish plated traditionally or with our modern interpretation?', 'Let\'s go with the modern interpretation, I\'m curious what that looks like.'),
(@set_id, 14, 'How did the textural contrast in that course land for you?', 'Really well, actually — the crunch against the creamy base worked beautifully.'),
(@set_id, 15, 'We source many ingredients locally and seasonally — any thoughts on that?', 'I really appreciate that approach, it usually shows in the freshness of the dish.'),
(@set_id, 16, 'Would you like us to walk you through the inspiration behind this menu?', 'Please do, I always find the story behind a dish adds to the experience.'),
(@set_id, 17, 'How do you feel about unconventional pairings, like savory with dessert elements?', 'I\'m generally open to it, as long as the balance feels intentional, not gimmicky.'),
(@set_id, 18, 'Would you like to finish with something experimental from our dessert program?', 'Yes, let\'s do it, I trust the kitchen\'s judgment at this point.'),
(@set_id, 19, 'What stood out most to you about tonight\'s meal overall?', 'The consistency across courses — nothing felt like an afterthought.'),
(@set_id, 20, 'It\'s been a genuine pleasure hosting such an engaged table tonight.', 'The pleasure was entirely ours, this was a memorable meal.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'travel';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Do you like to travel?', 'Yes, I really enjoy traveling.'),
(@set_id, 2, 'Where do you want to go next?', 'I want to visit Japan next.'),
(@set_id, 3, 'How do you usually travel, by plane or train?', 'I usually travel by plane.'),
(@set_id, 4, 'What do you pack for a trip?', 'I pack clothes, a camera, and my passport.'),
(@set_id, 5, 'Do you like to travel alone or with friends?', 'I like to travel with friends.'),
(@set_id, 6, 'What is your favorite place you have visited?', 'My favorite place is Paris.'),
(@set_id, 7, 'Do you take a lot of photos when you travel?', 'Yes, I take many photos.'),
(@set_id, 8, 'I hope your next trip is amazing!', 'Thank you, I can\'t wait!'),
(@set_id, 9, 'Have you ever traveled by train?', 'Yes, I have traveled by train many times.'),
(@set_id, 10, 'Do you like traveling in summer or winter?', 'I like traveling in winter more.'),
(@set_id, 11, 'How do you choose where to travel?', 'I usually ask my friends for ideas.'),
(@set_id, 12, 'Do you take a lot of luggage when you travel?', 'No, I like to travel light.'),
(@set_id, 13, 'What is your dream travel destination?', 'My dream destination is Switzerland.'),
(@set_id, 14, 'Do you buy souvenirs when you travel?', 'Yes, I always buy small souvenirs.'),
(@set_id, 15, 'How do you plan your trips?', 'I plan them a few months in advance.'),
(@set_id, 16, 'Do you like adventure travel or relaxing trips?', 'I prefer relaxing trips near the beach.'),
(@set_id, 17, 'Have you traveled outside your country?', 'Yes, I have visited two other countries.'),
(@set_id, 18, 'Do you use travel apps to plan your trip?', 'Yes, I use apps to book hotels.'),
(@set_id, 19, 'What do you always bring on a trip?', 'I always bring my phone charger.'),
(@set_id, 20, 'I hope you have a wonderful trip!', 'Thank you so much, I can\'t wait.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'travel';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'What\'s the most memorable trip you\'ve ever taken?', 'A road trip along the coast with my family was unforgettable.'),
(@set_id, 2, 'Do you prefer planning every detail or traveling spontaneously?', 'I like having a rough plan but leaving room for surprises.'),
(@set_id, 3, 'How do you usually find good places to eat while traveling?', 'I ask locals or check reviews from other travelers online.'),
(@set_id, 4, 'What\'s something you always pack that others might forget?', 'I always bring a small first-aid kit, just in case.'),
(@set_id, 5, 'Have you ever had a travel plan go completely wrong?', 'Yes, once my flight got cancelled and I had to rebook everything.'),
(@set_id, 6, 'How do you handle unexpected problems while traveling?', 'I try to stay calm and look for the next best option.'),
(@set_id, 7, 'What destination is currently on your travel wish list?', 'I\'d really love to visit New Zealand someday.'),
(@set_id, 8, 'That sounds like an amazing place to explore.', 'I hope so, I\'ve heard the scenery is incredible.'),
(@set_id, 9, 'Do you usually travel with a fixed budget in mind?', 'Yes, I set a rough budget so I don\'t overspend along the way.'),
(@set_id, 10, 'What\'s your approach to packing for a trip?', 'I make a checklist a few days early so nothing gets forgotten.'),
(@set_id, 11, 'How do you decide between exploring cities or nature during a trip?', 'I usually try to mix both so the trip doesn\'t feel one-note.'),
(@set_id, 12, 'What\'s a travel mistake you learned a lot from?', 'Not booking accommodation early enough during a busy holiday season once.'),
(@set_id, 13, 'Do you prefer guided tours or exploring on your own?', 'I lean toward exploring on my own, it feels more authentic to me.'),
(@set_id, 14, 'How do you handle language barriers while traveling?', 'I learn a few basic phrases beforehand, it goes a long way.'),
(@set_id, 15, 'What\'s the most underrated destination you\'ve visited?', 'A small coastal town that barely anyone I know had heard of.'),
(@set_id, 16, 'Do you keep a journal or take a lot of photos while traveling?', 'Mostly photos, though I\'ve started jotting down quick notes too.'),
(@set_id, 17, 'How do you decide what local food to try while traveling?', 'I usually ask locals directly instead of relying only on online reviews.'),
(@set_id, 18, 'What\'s something that always surprises you when you travel?', 'How different daily rhythms are from place to place, even nearby ones.'),
(@set_id, 19, 'Do you prefer traveling solo or with company?', 'A mix, honestly — solo trips for reflection, group trips for fun.'),
(@set_id, 20, 'It sounds like you\'ve picked up a lot of travel wisdom.', 'I have, mostly the hard way, through trial and error.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'travel';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'How has traveling changed your perspective on life?', 'It\'s taught me to be more adaptable and less attached to routine.'),
(@set_id, 2, 'Do you think mass tourism is harming the places we love to visit?', 'In some cases, yes, it strains resources and changes local culture.'),
(@set_id, 3, 'What\'s a more responsible way to travel that you try to practice?', 'I try to support local businesses instead of large international chains.'),
(@set_id, 4, 'Have you ever experienced meaningful culture shock somewhere?', 'Definitely, adjusting to a completely different pace of life took time.'),
(@set_id, 5, 'How do you prepare mentally before visiting an unfamiliar culture?', 'I read about local customs beforehand so I don\'t accidentally offend anyone.'),
(@set_id, 6, 'Do you think traveling alone teaches you more than traveling with others?', 'In different ways, yes, solo travel forces you to rely on yourself more.'),
(@set_id, 7, 'What\'s the most valuable lesson a trip has taught you?', 'That plans rarely go perfectly, and that\'s often where the best stories come from.'),
(@set_id, 8, 'Thank you for sharing such thoughtful travel reflections.', 'Happy to, travel always gives me a lot to think about.'),
(@set_id, 9, 'Do you think travel genuinely broadens perspective, or is that overstated?', 'It can, but only if you engage thoughtfully rather than just passing through.'),
(@set_id, 10, 'How do you navigate the tension between tourism and respecting local culture?', 'I try to research customs beforehand and defer to locals\' preferences over convenience.'),
(@set_id, 11, 'What\'s a trip that fundamentally changed how you see the world?', 'Living briefly in a much slower-paced country reshaped my relationship with time.'),
(@set_id, 12, 'Do you think overtourism is something individual travelers can meaningfully address?', 'To a degree — choosing off-peak times and less-trodden destinations genuinely helps.'),
(@set_id, 13, 'How do you evaluate whether a destination is \'worth\' visiting?', 'I\'ve stopped ranking destinations that way — every place offers something if you\'re open to it.'),
(@set_id, 14, 'What\'s your view on \'bucket list\' travel culture?', 'I think it can turn travel into checkbox tourism rather than genuine experience.'),
(@set_id, 15, 'Do you think traveling alone changes your capacity for self-reflection?', 'Significantly — there\'s a kind of clarity that only comes without familiar distractions.'),
(@set_id, 16, 'How do you reconcile travel\'s environmental cost with its personal value?', 'I try to travel less frequently but stay longer, reducing footprint per trip.'),
(@set_id, 17, 'What\'s a cultural assumption travel has forced you to reconsider?', 'That efficiency is universally valued — many places prioritize relationships over speed.'),
(@set_id, 18, 'Do you think it\'s possible to travel \'ethically\' in a globalized economy?', 'Imperfectly, yes — mindful choices reduce harm even if they can\'t eliminate it.'),
(@set_id, 19, 'How has travel influenced your definition of \'home\'?', 'It\'s become less about a fixed place and more about familiar routines and people.'),
(@set_id, 20, 'This conversation went far deeper into travel than I expected.', 'It did — travel tends to surface bigger questions than it seems to on the surface.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'hotel';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Welcome to our hotel. Do you have a reservation?', 'Yes, I have a reservation under my name.'),
(@set_id, 2, 'May I see your ID, please?', 'Sure, here is my ID.'),
(@set_id, 3, 'Your room is on the fifth floor.', 'Thank you. Where is the elevator?'),
(@set_id, 4, 'The elevator is right over there.', 'Thank you very much.'),
(@set_id, 5, 'Do you need help with your luggage?', 'Yes, please, that would be helpful.'),
(@set_id, 6, 'Breakfast is served from seven to ten.', 'Great, thank you for letting me know.'),
(@set_id, 7, 'Is there anything else you need?', 'No, that\'s everything, thank you.'),
(@set_id, 8, 'Enjoy your stay with us!', 'Thank you, I\'m sure I will.'),
(@set_id, 9, 'What time can I check in?', 'You can check in after two o\'clock.'),
(@set_id, 10, 'Does the room have wifi?', 'Yes, wifi is free in every room.'),
(@set_id, 11, 'Is there a swimming pool here?', 'Yes, the pool is on the roof.'),
(@set_id, 12, 'Can I get a wake-up call tomorrow?', 'Yes, what time would you like?'),
(@set_id, 13, 'Is breakfast included with the room?', 'Yes, breakfast is included every day.'),
(@set_id, 14, 'What time is checkout?', 'Checkout is at eleven in the morning.'),
(@set_id, 15, 'Can I have a room on a higher floor?', 'Yes, I can arrange that for you.'),
(@set_id, 16, 'Is there parking available for guests?', 'Yes, parking is free for all guests.'),
(@set_id, 17, 'Can housekeeping clean my room now?', 'Yes, I will send someone right away.'),
(@set_id, 18, 'Is there a restaurant in the hotel?', 'Yes, it\'s on the ground floor.'),
(@set_id, 19, 'Can I extend my stay one more night?', 'Yes, let me check room availability.'),
(@set_id, 20, 'Thank you for staying with us!', 'Thank you, we had a great stay.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'hotel';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Welcome back. Would you like the same room as last time?', 'Yes, that would be great, I really liked the view.'),
(@set_id, 2, 'Of course. Would you also like to add breakfast to your stay?', 'Yes, please add breakfast for both mornings.'),
(@set_id, 3, 'Is there anything specific you\'ll need during your stay?', 'Could I get an extra pillow and some extra towels?'),
(@set_id, 4, 'Certainly, I\'ll have that sent up right away.', 'Thank you, I really appreciate the quick service.'),
(@set_id, 5, 'Would you like a wake-up call in the morning?', 'Yes, please set it for seven thirty.'),
(@set_id, 6, 'Noted. Is the room temperature comfortable for you?', 'It\'s a bit warm, could you lower it slightly?'),
(@set_id, 7, 'Of course, I\'ll adjust that for you right now.', 'Thank you, that\'s much better now.'),
(@set_id, 8, 'Let us know if you need anything else during your stay.', 'I will, thank you for taking care of everything.'),
(@set_id, 9, 'Would you like a room with a city view or a garden view?', 'A garden view sounds more peaceful, let\'s go with that.'),
(@set_id, 10, 'Is there anything specific that would make your stay more comfortable?', 'A quieter room away from the elevator would be great, if possible.'),
(@set_id, 11, 'Would you like us to arrange airport transportation for your departure?', 'Yes, that would be really helpful, thank you for offering.'),
(@set_id, 12, 'How did you find the room temperature and amenities?', 'Everything was comfortable, the bed was especially nice.'),
(@set_id, 13, 'Would you like recommendations for restaurants within walking distance?', 'Yes, please, we\'d love to explore somewhere local for dinner.'),
(@set_id, 14, 'Is there a specific time you\'d prefer for daily housekeeping?', 'Sometime in the late morning works best for our schedule.'),
(@set_id, 15, 'Would you like to upgrade to a suite for the remainder of your stay?', 'That sounds tempting, could you tell me the price difference?'),
(@set_id, 16, 'How has your experience with our staff been so far?', 'Everyone has been incredibly attentive and quick to help.'),
(@set_id, 17, 'Would you like a late checkout tomorrow before your flight?', 'Yes, that would be perfect, our flight isn\'t until the evening.'),
(@set_id, 18, 'Is there anything from your stay you\'d like us to improve?', 'Just the wifi speed in the room, otherwise everything was excellent.'),
(@set_id, 19, 'Would you consider staying with us again on your next visit?', 'Definitely, this has been one of our favorite hotel stays.'),
(@set_id, 20, 'We really appreciate your feedback and your stay with us.', 'Thank you for taking such good care of us throughout.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'hotel';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'I understand there was an issue with your room earlier. I\'m sorry about that.', 'It\'s alright, but the air conditioning wasn\'t working properly last night.'),
(@set_id, 2, 'I sincerely apologize, let me arrange for maintenance immediately.', 'I appreciate that, and perhaps a small compensation for the inconvenience.'),
(@set_id, 3, 'Absolutely, we\'ll offer you a complimentary dinner at our restaurant tonight.', 'That\'s very kind of you, thank you for resolving this so quickly.'),
(@set_id, 4, 'We truly value your loyalty as a returning guest.', 'I do enjoy staying here, the staff always go above and beyond.'),
(@set_id, 5, 'Is there anything else about your stay you\'d like to discuss?', 'Actually, could you recommend some quieter attractions nearby for tomorrow?'),
(@set_id, 6, 'Certainly, there\'s a peaceful botanical garden just a short walk away.', 'That sounds perfect, exactly the kind of relaxation I was hoping for.'),
(@set_id, 7, 'I\'ll have the concierge print you a small map with directions.', 'Thank you, that\'s incredibly thoughtful of you.'),
(@set_id, 8, 'We hope the rest of your stay is much smoother.', 'I\'m sure it will be, thanks again for handling everything so well.'),
(@set_id, 9, 'We noticed this is a recurring booking — is there a standing preference we should note on file?', 'Yes, please note I prefer higher floors away from the elevator shaft.'),
(@set_id, 10, 'Would you be interested in our loyalty program given how often you stay with us?', 'I would, actually — could you walk me through what tier benefits look like?'),
(@set_id, 11, 'How do you weigh personalized service against pure luxury amenities when choosing hotels?', 'Personalized service wins for me, amenities matter far less than feeling genuinely looked after.'),
(@set_id, 12, 'We\'re renovating the floor below yours — will that affect your stay noticeably?', 'I appreciate the heads-up, could we possibly move to a quieter floor instead?'),
(@set_id, 13, 'Would you like our concierge to curate an itinerary based on your specific interests?', 'That would be wonderful, I\'m particularly interested in local art and architecture.'),
(@set_id, 14, 'How do you generally handle unexpected service issues during a stay?', 'I address them calmly and promptly, most staff genuinely want to make things right.'),
(@set_id, 15, 'We pride ourselves on sustainable practices — does that factor into your hotel choices?', 'It does, increasingly, I actively look for that when booking accommodations now.'),
(@set_id, 16, 'Would you prefer we consolidate your billing across your visits into a single corporate account?', 'Yes, that would simplify things considerably for my expense reporting.'),
(@set_id, 17, 'How do you evaluate whether a luxury stay actually justified its price?', 'By whether the small details were considered, not just the obvious grand gestures.'),
(@set_id, 18, 'Would you like feedback from previous guests factored into how we assign your room?', 'That\'s thoughtful, yes — I\'d appreciate rooms with minimal noted noise complaints.'),
(@set_id, 19, 'What has kept you loyal to this hotel chain over the years?', 'Consistency, honestly — I know almost exactly what to expect at every property.'),
(@set_id, 20, 'It\'s guests like you that help us continually refine the experience.', 'I\'m glad to contribute, and I genuinely enjoy staying here each time.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'airport';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Good morning. May I see your ticket and passport?', 'Sure, here they are.'),
(@set_id, 2, 'Do you have any luggage to check in?', 'Yes, I have one suitcase.'),
(@set_id, 3, 'Please place your bag on the scale.', 'Okay, here you go.'),
(@set_id, 4, 'Your gate is B12. Boarding starts at nine.', 'Thank you, where is gate B12?'),
(@set_id, 5, 'Go straight and turn left after security.', 'Thank you very much for your help.'),
(@set_id, 6, 'Please remove your shoes and laptop for security.', 'Okay, I\'m taking them out now.'),
(@set_id, 7, 'You may proceed through security now.', 'Thank you, have a good day.'),
(@set_id, 8, 'Have a safe flight!', 'Thank you, I will.'),
(@set_id, 9, 'Do you have any liquids in your bag?', 'No, I don\'t have any liquids.'),
(@set_id, 10, 'Is this your first flight today?', 'Yes, this is my first flight.'),
(@set_id, 11, 'Which airline are you flying with?', 'I am flying with Delta Airlines.'),
(@set_id, 12, 'Do you need a wheelchair or assistance?', 'No, I don\'t need any assistance.'),
(@set_id, 13, 'Where can I find the currency exchange?', 'It\'s near gate five, on your right.'),
(@set_id, 14, 'How long is the flight?', 'The flight is about six hours.'),
(@set_id, 15, 'Is there a delay for my flight?', 'No, your flight is on time.'),
(@set_id, 16, 'Where do I collect my baggage?', 'Baggage claim is on the first floor.'),
(@set_id, 17, 'Is there free wifi at the airport?', 'Yes, wifi is free for all passengers.'),
(@set_id, 18, 'Can I bring food through security?', 'Yes, solid food is usually allowed.'),
(@set_id, 19, 'Where is the nearest restroom?', 'It\'s just past the food court.'),
(@set_id, 20, 'Enjoy the rest of your trip!', 'Thank you, I will.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'airport';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Welcome, are you checking any bags today?', 'Yes, just this one suitcase, it should be under the weight limit.'),
(@set_id, 2, 'It looks good. Would you like a window or aisle seat?', 'A window seat would be great, if it\'s available.'),
(@set_id, 3, 'You\'re all set with seat fourteen A. Here\'s your boarding pass.', 'Thank you, what time does boarding begin?'),
(@set_id, 4, 'Boarding starts at ten fifteen from gate twenty-two.', 'Got it, is there a lounge nearby I could relax in?'),
(@set_id, 5, 'Yes, there\'s a lounge right past security on the second floor.', 'Perfect, thank you for the information.'),
(@set_id, 6, 'Is this your first time flying with us?', 'No, actually I\'ve flown with your airline a few times before.'),
(@set_id, 7, 'Great to hear, we hope you continue enjoying the experience.', 'I definitely will, your service has always been reliable.'),
(@set_id, 8, 'Safe travels, and thank you for choosing us.', 'Thank you, I\'m looking forward to the flight.'),
(@set_id, 9, 'Would you like priority boarding since you\'re traveling with a child?', 'Yes, that would make things much easier for us, thank you.'),
(@set_id, 10, 'How much time do you usually leave for airport security?', 'I try to arrive at least two hours early, just to be safe.'),
(@set_id, 11, 'Do you prefer window or aisle seats on longer flights?', 'Aisle seats, honestly, I like being able to get up freely.'),
(@set_id, 12, 'Is your connecting flight with the same airline?', 'Yes, it\'s a codeshare, so the transfer should be fairly seamless.'),
(@set_id, 13, 'How do you usually pass the time during long layovers?', 'I catch up on reading or just walk around the terminal.'),
(@set_id, 14, 'Would you like to check your carry-on given the overhead bins are full?', 'Sure, that\'s fine, as long as I keep my essentials with me.'),
(@set_id, 15, 'Do you have any connecting baggage that needs to be rechecked?', 'No, it\'s checked all the way through to my final destination.'),
(@set_id, 16, 'How do you manage jet lag on long-haul flights?', 'I try to adjust my sleep schedule a couple of days before departure.'),
(@set_id, 17, 'Is this a business trip or a personal trip for you?', 'A bit of both, actually — a conference followed by a short vacation.'),
(@set_id, 18, 'Would you like access to the lounge while you wait?', 'Yes, please, that would be a nice way to relax before boarding.'),
(@set_id, 19, 'Do you usually travel with just carry-on luggage?', 'For short trips, yes, it saves a lot of time at baggage claim.'),
(@set_id, 20, 'We hope you have a smooth and comfortable flight.', 'Thank you very much, I appreciate all your help today.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'airport';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'I noticed there\'s a slight delay with your connecting flight. Let me check the options.', 'I appreciate that, I was worried I might miss my connection entirely.'),
(@set_id, 2, 'Fortunately, we can rebook you on a later flight with a similar arrival time.', 'That\'s a relief, thank you for sorting this out so smoothly.'),
(@set_id, 3, 'Would you prefer a direct route or one with a shorter layover?', 'A shorter layover would be ideal, I\'d rather not wait too long.'),
(@set_id, 4, 'I\'ve found one with just a forty-minute layover, does that work?', 'That sounds perfect, please go ahead and book that one.'),
(@set_id, 5, 'All set, here\'s your updated itinerary and boarding information.', 'Thank you so much, this really eased my mind about the trip.'),
(@set_id, 6, 'Do you travel frequently for work or mostly for leisure?', 'Mostly for work these days, though I try to sneak in leisure time too.'),
(@set_id, 7, 'That\'s a great way to make the most of business trips.', 'Exactly, it makes the travel feel a lot less exhausting.'),
(@set_id, 8, 'I hope the rest of your journey goes smoothly from here.', 'Thank you again for your help, I really appreciate the effort.'),
(@set_id, 9, 'Given the irregular operations today, would you like us to proactively rebook your onward connections?', 'Yes, please, I\'d rather not risk a missed connection given the current delays.'),
(@set_id, 10, 'How do you generally handle the uncertainty of last-minute itinerary changes?', 'I try to stay flexible and always keep a buffer day when possible for exactly this reason.'),
(@set_id, 11, 'Would you be interested in compensation options given the significant delay you\'ve experienced?', 'I would, could you outline what\'s typically offered in situations like this?'),
(@set_id, 12, 'How do frequent long-haul flights affect your overall approach to travel planning?', 'I\'ve become far more deliberate about routing, even if it means slightly higher costs.'),
(@set_id, 13, 'Would you like us to coordinate directly with your connecting airline regarding the missed transfer?', 'That would be extremely helpful, thank you for taking that off my hands.'),
(@set_id, 14, 'What\'s your view on airlines\' increasing reliance on dynamic pricing for last-minute changes?', 'It\'s frustrating as a consumer, though I understand the operational logic behind it.'),
(@set_id, 15, 'How do you evaluate whether travel insurance is worth it for a given trip?', 'I weigh it against the total cost and complexity of the itinerary involved.'),
(@set_id, 16, 'Would you prefer we proactively notify you of gate changes via text going forward?', 'Yes, that would definitely help me avoid last-minute scrambling in the terminal.'),
(@set_id, 17, 'How has increased automation changed your experience navigating large airports?', 'It\'s sped things up significantly, though I still value having staff available when needed.'),
(@set_id, 18, 'Do you think airport design genuinely accounts for traveler wellbeing, or mostly efficiency?', 'Mostly efficiency, unfortunately — comfort often feels like an afterthought in most terminals.'),
(@set_id, 19, 'What\'s a small airport convenience that\'s made a noticeable difference for you?', 'Mobile boarding passes, honestly — it\'s removed so much unnecessary friction.'),
(@set_id, 20, 'We appreciate your patience navigating today\'s disruptions.', 'I appreciate how proactively your team has handled everything, genuinely.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'meeting-someone';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hi, I don\'t think we\'ve met. I\'m Alex.', 'Nice to meet you, Alex. I\'m Sam.'),
(@set_id, 2, 'Nice to meet you too, Sam. Where are you from?', 'I\'m from Delhi. And you?'),
(@set_id, 3, 'I\'m from London. What do you do?', 'I\'m a teacher. What about you?'),
(@set_id, 4, 'I work in marketing. How old are you?', 'I\'m twenty-five years old.'),
(@set_id, 5, 'Nice! Do you have any hobbies?', 'Yes, I like reading and cooking.'),
(@set_id, 6, 'That sounds fun. Are you married?', 'No, I\'m single right now.'),
(@set_id, 7, 'I see. It was really nice meeting you.', 'It was nice meeting you too.'),
(@set_id, 8, 'Let\'s stay in touch!', 'Sure, let\'s exchange numbers.'),
(@set_id, 9, 'What is your last name?', 'My last name is Sharma.'),
(@set_id, 10, 'How do you spell your name?', 'It is spelled S-A-M.'),
(@set_id, 11, 'Are you new to this city?', 'Yes, I moved here recently.'),
(@set_id, 12, 'Do you live near here?', 'Yes, I live just a few minutes away.'),
(@set_id, 13, 'What do you do for fun?', 'I like painting and cycling.'),
(@set_id, 14, 'Do you have any children?', 'No, I don\'t have children yet.'),
(@set_id, 15, 'How did you two meet?', 'We met through a mutual friend.'),
(@set_id, 16, 'What is your phone number?', 'It\'s on my business card here.'),
(@set_id, 17, 'Do you use social media?', 'Yes, I use it sometimes.'),
(@set_id, 18, 'What is your email address?', 'I\'ll write it down for you.'),
(@set_id, 19, 'Would you like to grab coffee sometime?', 'Yes, that sounds really nice.'),
(@set_id, 20, 'It was great meeting you today.', 'It was great meeting you too.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'meeting-someone';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hi, I don\'t think we\'ve officially met yet. I\'m Jordan.', 'Nice to finally meet you, Jordan. I\'ve heard great things about you.'),
(@set_id, 2, 'That\'s kind of you to say. What brings you to this event?', 'I\'m here mostly to network and learn a bit more about the industry.'),
(@set_id, 3, 'Same here actually. What field are you currently working in?', 'I work in digital marketing, mainly focused on social media strategy.'),
(@set_id, 4, 'Interesting, that\'s a fast-changing field these days.', 'It really is, I have to keep learning something new every week.'),
(@set_id, 5, 'How long have you been in this line of work?', 'About four years now, and I\'m really enjoying the challenge.'),
(@set_id, 6, 'That\'s great to hear. Any exciting projects at the moment?', 'Yes, I\'m currently working on a campaign launch for a new client.'),
(@set_id, 7, 'That sounds exciting, I\'d love to hear more sometime.', 'Definitely, let\'s grab coffee and chat about it in more detail.'),
(@set_id, 8, 'Sounds like a plan. Great meeting you today.', 'Likewise, looking forward to staying in touch.'),
(@set_id, 9, 'So how do you two know each other?', 'We actually went to the same university a few years apart.'),
(@set_id, 10, 'What line of work are you in these days?', 'I work in graphic design, mostly for small businesses.'),
(@set_id, 11, 'How long have you been living in this area?', 'About three years now, and I\'ve really grown to like it.'),
(@set_id, 12, 'What made you decide to attend this event today?', 'A colleague recommended it, and the topic sounded genuinely interesting.'),
(@set_id, 13, 'Do you have any hobbies outside of work?', 'Yes, I do a lot of hiking whenever I get the chance.'),
(@set_id, 14, 'What\'s something people are usually surprised to learn about you?', 'That I used to compete in amateur chess tournaments as a teenager.'),
(@set_id, 15, 'How do you usually meet new people in a new city?', 'Mostly through hobby groups, they make conversation feel natural.'),
(@set_id, 16, 'What\'s a book or podcast you\'d recommend to someone you just met?', 'Honestly, whatever I\'m currently into — right now it\'s a history podcast.'),
(@set_id, 17, 'Do you prefer small gatherings or bigger social events?', 'Smaller gatherings, definitely, I find deeper conversations happen there.'),
(@set_id, 18, 'What\'s the best piece of advice someone\'s given you recently?', 'To ask more questions and talk less, it\'s improved my conversations a lot.'),
(@set_id, 19, 'Would you be interested in joining our group for the next meetup?', 'I\'d love to, please send me the details whenever it\'s confirmed.'),
(@set_id, 20, 'This was a really pleasant conversation, thank you.', 'Likewise, I\'m glad we finally got the chance to talk properly.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'meeting-someone';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'I believe we have a mutual connection, though we haven\'t formally met.', 'Ah yes, I think I\'ve heard your name mentioned a few times, good things of course.'),
(@set_id, 2, 'That\'s reassuring to hear. What draws you to this particular industry?', 'Honestly, the constant problem-solving keeps me engaged, no two days look the same.'),
(@set_id, 3, 'I can relate to that. What\'s been the biggest challenge in your career so far?', 'Probably learning to delegate; I used to try handling everything myself.'),
(@set_id, 4, 'That\'s a common struggle, especially for people who start out very hands-on.', 'Exactly, it took a few burned-out weeks before I really learned the lesson.'),
(@set_id, 5, 'How do you think your industry will look five years from now?', 'I imagine automation will handle more routine tasks, freeing us for strategic work.'),
(@set_id, 6, 'That aligns with what I\'ve been observing as well.', 'It\'s reassuring to hear someone else sees the same trend forming.'),
(@set_id, 7, 'I\'ve really enjoyed this conversation, it\'s rare to find such alignment quickly.', 'Agreed, I\'d love to continue this discussion over coffee sometime soon.'),
(@set_id, 8, 'Let\'s definitely make that happen. Great meeting you.', 'Likewise, I\'ll follow up with you this week to set something up.'),
(@set_id, 9, 'What initially drew you toward the field you\'re currently working in?', 'A somewhat accidental internship that turned into a genuine long-term passion.'),
(@set_id, 10, 'How do you typically build rapport with people from very different backgrounds than yours?', 'I focus on shared curiosity rather than surface-level similarities.'),
(@set_id, 11, 'Do you find it easier to connect with people through shared struggles or shared successes?', 'Struggles, honestly — vulnerability tends to build trust faster than achievement does.'),
(@set_id, 12, 'What\'s a professional risk you took that ended up paying off unexpectedly?', 'Leaving a stable role for a startup that initially seemed far too uncertain.'),
(@set_id, 13, 'How do you navigate first impressions when you know they can be misleading?', 'I try to withhold judgment and revisit my impression after a few real interactions.'),
(@set_id, 14, 'What\'s something you\'ve learned about yourself through building new relationships as an adult?', 'That I value depth over frequency — a few close connections matter more than many casual ones.'),
(@set_id, 15, 'Do you think shared values matter more than shared interests in lasting friendships?', 'Values, ultimately — interests can diverge, but core values tend to hold relationships together.'),
(@set_id, 16, 'How has your approach to networking evolved over the years?', 'I\'ve moved from transactional networking to just genuinely staying curious about people.'),
(@set_id, 17, 'What\'s a conversation topic you find instantly reveals someone\'s character?', 'How they talk about people who aren\'t in the room — it says a lot.'),
(@set_id, 18, 'Do you think it\'s possible to form meaningful connections quickly, or does it always take time?', 'It\'s possible in flashes, though sustaining it still requires consistent effort over time.'),
(@set_id, 19, 'What\'s the most unexpected friendship you\'ve formed as an adult?', 'With someone twenty years older than me, through a completely unrelated hobby.'),
(@set_id, 20, 'This has been a far more meaningful conversation than I expected today.', 'Same here — it\'s rare to get this candid so early into meeting someone.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'job-interview';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Good morning, please have a seat. Tell me about yourself.', 'Good morning. I\'m a hardworking and friendly person.'),
(@set_id, 2, 'Why do you want this job?', 'I want this job because I like this kind of work.'),
(@set_id, 3, 'What are your strengths?', 'I am organized and I learn quickly.'),
(@set_id, 4, 'What are your weaknesses?', 'Sometimes I work too slowly, but I am improving.'),
(@set_id, 5, 'Do you have any experience in this field?', 'Yes, I worked in a similar job for one year.'),
(@set_id, 6, 'Are you available to start next week?', 'Yes, I am available to start next week.'),
(@set_id, 7, 'Do you have any questions for me?', 'Yes, what are the working hours?'),
(@set_id, 8, 'Thank you for coming today. We will contact you soon.', 'Thank you very much for your time.'),
(@set_id, 9, 'Why did you leave your last job?', 'I wanted a new challenge.'),
(@set_id, 10, 'What days can you work?', 'I can work any day of the week.'),
(@set_id, 11, 'Do you have a resume with you?', 'Yes, here is my resume.'),
(@set_id, 12, 'Can you work in a team?', 'Yes, I work well in a team.'),
(@set_id, 13, 'What is your greatest achievement?', 'Finishing my degree while working full-time.'),
(@set_id, 14, 'Are you comfortable with computers?', 'Yes, I am very comfortable with them.'),
(@set_id, 15, 'Do you have any references?', 'Yes, I can provide two references.'),
(@set_id, 16, 'Can you start immediately?', 'Yes, I can start right away.'),
(@set_id, 17, 'How do you handle stress at work?', 'I stay calm and make a plan.'),
(@set_id, 18, 'What skills make you a good fit?', 'My communication and organization skills.'),
(@set_id, 19, 'Do you have any certifications?', 'Yes, I have a certificate in accounting.'),
(@set_id, 20, 'We will call you with our decision.', 'Thank you, I look forward to hearing from you.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'job-interview';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Thanks for coming in today. Can you walk me through your background?', 'Of course, I have three years of experience in customer service and team leadership.'),
(@set_id, 2, 'That\'s great experience. Why are you interested in this position?', 'I\'m looking for a role with more responsibility, and this position fits that well.'),
(@set_id, 3, 'Can you describe a challenge you faced at your last job?', 'Yes, I once had to manage a team through a tight project deadline successfully.'),
(@set_id, 4, 'How did you handle the pressure during that time?', 'I broke the project into smaller tasks and checked in with the team daily.'),
(@set_id, 5, 'That shows strong leadership skills. How do you handle conflict at work?', 'I try to listen to both sides first before suggesting a fair solution.'),
(@set_id, 6, 'Good approach. What are your salary expectations for this role?', 'I\'m flexible, but I\'m hoping for something competitive based on my experience.'),
(@set_id, 7, 'That\'s reasonable. Do you have any questions for us?', 'Yes, what does a typical day look like in this role?'),
(@set_id, 8, 'Great question, let me explain that in detail.', 'Thank you, I appreciate you taking the time to explain.'),
(@set_id, 9, 'Can you describe a time you had to learn something quickly on the job?', 'Yes, I had to learn a new software system within a week for a client project.'),
(@set_id, 10, 'How do you typically prioritize tasks when everything feels urgent?', 'I rank tasks by actual deadlines and impact, not just how loud the request is.'),
(@set_id, 11, 'What would your previous manager say is your biggest strength?', 'Probably reliability — I consistently deliver what I commit to on time.'),
(@set_id, 12, 'How do you approach receiving feedback that you disagree with?', 'I ask clarifying questions first, then decide if adjustment is genuinely needed.'),
(@set_id, 13, 'Tell me about a time you disagreed with a team decision.', 'I voiced my concerns respectfully, and once the decision was made, I supported it fully.'),
(@set_id, 14, 'What kind of work environment brings out your best performance?', 'One with clear expectations but enough autonomy to solve problems my own way.'),
(@set_id, 15, 'How do you stay motivated during repetitive or less exciting tasks?', 'I connect them to the bigger outcome they contribute to, which keeps me focused.'),
(@set_id, 16, 'What\'s a professional skill you\'re currently trying to improve?', 'Public speaking — I\'ve been taking opportunities to present more often.'),
(@set_id, 17, 'How would you handle a disagreement with a coworker on a shared project?', 'I\'d address it directly and privately, focusing on the work rather than personalities.'),
(@set_id, 18, 'What questions do you have about the day-to-day responsibilities of this role?', 'I\'d love to know what a typical first month looks like for this position.'),
(@set_id, 19, 'Is there anything about our company culture you\'re curious about?', 'Yes, how does the team usually handle collaboration across departments?'),
(@set_id, 20, 'Thank you, we\'ll be in touch within the week.', 'Thank you for your time today, I really enjoyed this conversation.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'job-interview';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Let\'s start with an overview: what draws you specifically to our company?', 'Your emphasis on innovation and employee growth really aligns with my career goals.'),
(@set_id, 2, 'That\'s good to hear. Can you tell me about a time you failed at something significant?', 'Certainly, early in my career I underestimated a project timeline, which taught me to plan more conservatively.'),
(@set_id, 3, 'How did that experience change your approach going forward?', 'I now build in buffer time and communicate risks earlier with stakeholders.'),
(@set_id, 4, 'That\'s a mature response. How do you prioritize competing deadlines?', 'I evaluate impact and urgency, then communicate trade-offs clearly with my team.'),
(@set_id, 5, 'Where do you see yourself professionally in the next five years?', 'I\'d like to move into a leadership role where I can mentor others and drive strategy.'),
(@set_id, 6, 'That aligns well with our growth path here. How do you handle receiving critical feedback?', 'I try to separate the feedback from my ego and focus on the specific improvement.'),
(@set_id, 7, 'That\'s a healthy mindset. Do you have any questions for us before we wrap up?', 'Yes, how does the company support long-term professional development for employees?'),
(@set_id, 8, 'Great question, I\'ll walk you through our mentorship and training programs.', 'Thank you, that\'s exactly the kind of environment I\'m looking to grow in.'),
(@set_id, 9, 'Walk me through a decision you made that had significant downstream consequences.', 'I chose to delay a launch for additional testing, which cost time but prevented a major bug in production.'),
(@set_id, 10, 'How do you approach situations where data and intuition seem to conflict?', 'I dig deeper into the data first, but I don\'t dismiss intuition without understanding its source.'),
(@set_id, 11, 'What\'s an example of you influencing a decision without having direct authority?', 'I built a case with clear evidence and aligned stakeholders individually before the formal proposal.'),
(@set_id, 12, 'How do you handle leading a team through ambiguity when there\'s no clear playbook?', 'I set a short-term direction, communicate transparently about uncertainty, and adjust as we learn.'),
(@set_id, 13, 'Describe a time your initial assumption about a problem turned out to be wrong.', 'I assumed low engagement was a design issue, but data revealed it was actually a messaging problem.'),
(@set_id, 14, 'How do you balance moving quickly with ensuring quality in high-pressure situations?', 'I define what \'good enough\' looks like upfront, so speed doesn\'t quietly erode quality.'),
(@set_id, 15, 'What\'s your approach to giving difficult feedback to someone senior to you?', 'I focus on specific, observable behavior and frame it around shared goals, not personal criticism.'),
(@set_id, 16, 'How do you evaluate whether a failure was a process issue or an execution issue?', 'I trace the decision points backward to see where the breakdown actually originated.'),
(@set_id, 17, 'What\'s a long-term bet you made professionally that hasn\'t fully paid off yet?', 'Investing heavily in a skill set that\'s only recently started becoming relevant to my role.'),
(@set_id, 18, 'How do you maintain team morale during a prolonged period of uncertainty?', 'Frequent, honest communication — silence tends to breed more anxiety than difficult truths do.'),
(@set_id, 19, 'What would make you turn down an otherwise attractive offer?', 'A misalignment between the stated values and how decisions actually get made day to day.'),
(@set_id, 20, 'This has been an unusually substantive interview, thank you for your candor.', 'Thank you for asking questions that actually let me demonstrate how I think.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'office';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Good morning! Did you finish the report?', 'Yes, I finished it this morning.'),
(@set_id, 2, 'Great, can you send it to me?', 'Sure, I will send it right now.'),
(@set_id, 3, 'Do we have a meeting today?', 'Yes, we have a meeting at two o\'clock.'),
(@set_id, 4, 'Where is the meeting room?', 'It\'s on the third floor.'),
(@set_id, 5, 'Can you help me with this document?', 'Yes, of course. What do you need?'),
(@set_id, 6, 'Thank you, that\'s very helpful.', 'You\'re welcome, happy to help.'),
(@set_id, 7, 'Are you free for lunch today?', 'Yes, I am free at twelve thirty.'),
(@set_id, 8, 'Great, let\'s have lunch together.', 'Sounds good, see you then.'),
(@set_id, 9, 'Can you print this document for me?', 'Yes, I will print it now.'),
(@set_id, 10, 'Is the printer working today?', 'Yes, it is working fine.'),
(@set_id, 11, 'Where is the meeting room?', 'It\'s down the hall, on the left.'),
(@set_id, 12, 'Do you have a pen I can borrow?', 'Yes, here you go.'),
(@set_id, 13, 'What time is the team meeting?', 'It\'s at ten thirty.'),
(@set_id, 14, 'Can you send me that file?', 'Yes, I\'ll send it now.'),
(@set_id, 15, 'Are you coming to lunch with us?', 'Yes, I\'ll join you shortly.'),
(@set_id, 16, 'Did you finish the presentation?', 'Yes, it\'s ready for tomorrow.'),
(@set_id, 17, 'Can we reschedule our call?', 'Yes, what time works for you?'),
(@set_id, 18, 'Is the wifi working in your area?', 'Yes, it\'s working fine for me.'),
(@set_id, 19, 'Can you cc me on that email?', 'Yes, I\'ll add you now.'),
(@set_id, 20, 'Have a good rest of your day!', 'You too, thanks!');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'office';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Morning! Do you have a minute to go over the client proposal?', 'Sure, give me five minutes to finish this email first.'),
(@set_id, 2, 'No rush, just let me know when you\'re ready.', 'I\'m ready now, let\'s take a look at it together.'),
(@set_id, 3, 'I think we should adjust the timeline in section two.', 'I agree, the current deadline seems a bit too tight.'),
(@set_id, 4, 'Should we loop in the design team for their input?', 'Yes, that\'s a good idea, I\'ll send them the file now.'),
(@set_id, 5, 'Thanks. Are you handling the client call tomorrow?', 'Yes, I\'ll prepare a few talking points beforehand.'),
(@set_id, 6, 'Perfect, let me know if you need anything from me.', 'Will do, thanks for offering to help.'),
(@set_id, 7, 'Are we still on track for the project deadline?', 'Mostly, though we might need a couple of extra days.'),
(@set_id, 8, 'Okay, let\'s flag that in tomorrow\'s meeting.', 'Sounds good, I\'ll add it to the agenda.'),
(@set_id, 9, 'Could you walk me through the updated project timeline?', 'Sure, we\'ve pushed the deadline back by one week to accommodate testing.'),
(@set_id, 10, 'Do you think we have enough resources to meet this deadline?', 'It\'ll be tight, but I think it\'s achievable if nothing else comes up.'),
(@set_id, 11, 'How did the client meeting go this morning?', 'Really well, they seemed happy with the direction we\'re taking.'),
(@set_id, 12, 'Can you loop me in on the next status update call?', 'Of course, I\'ll add you to the invite right after this.'),
(@set_id, 13, 'What\'s blocking progress on your current task?', 'I\'m waiting on approval from another team before I can move forward.'),
(@set_id, 14, 'Should we bring this issue up in tomorrow\'s stand-up?', 'Yes, it\'s probably worth flagging before it becomes a bigger problem.'),
(@set_id, 15, 'How are you finding the new project management tool?', 'It\'s taken some adjusting, but it\'s more organized than our old system.'),
(@set_id, 16, 'Do you have bandwidth to take on an additional task this week?', 'I can, as long as it doesn\'t conflict with the current deadline.'),
(@set_id, 17, 'Can we sync briefly before the meeting with leadership?', 'Sure, does fifteen minutes beforehand work for you?'),
(@set_id, 18, 'What\'s your take on the feedback from yesterday\'s review?', 'Mostly fair — a few points I hadn\'t considered from that angle.'),
(@set_id, 19, 'Are you okay with presenting your part of the project tomorrow?', 'Yes, I\'ve already prepared my slides for it.'),
(@set_id, 20, 'Thanks for staying late to help wrap this up.', 'No problem, glad we got it done together.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'office';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Before the meeting, can we align on how to present the budget overrun?', 'Sure, I think we should be upfront about the cause and propose a solution immediately.'),
(@set_id, 2, 'Agreed, transparency will build more trust with leadership.', 'Exactly, and I\'ll prepare a revised forecast to back up our recommendation.'),
(@set_id, 3, 'How confident are you in the revised numbers holding up?', 'Fairly confident, though I\'ve built in some contingency given past estimation errors.'),
(@set_id, 4, 'Good call. Should we also address the resourcing gap in the same meeting?', 'I think so, it\'s closely tied to the budget issue and shouldn\'t be separated.'),
(@set_id, 5, 'Makes sense. Who do you think should lead that part of the discussion?', 'I\'d suggest you lead it since you have more context on the hiring plan.'),
(@set_id, 6, 'That works for me. Any concerns about how leadership might react?', 'A little, but I think a clear plan will help ease most of their concerns.'),
(@set_id, 7, 'Let\'s make sure our plan addresses their likely questions in advance.', 'Agreed, I\'ll draft some anticipated questions and answers before the meeting.'),
(@set_id, 8, 'Great, I think we\'re in good shape for tomorrow.', 'I think so too, thanks for working through this with me.'),
(@set_id, 9, 'Can you help me think through the trade-offs of scaling this initiative company-wide?', 'Sure — the main risk is losing the tailored approach that made it work in the pilot.'),
(@set_id, 10, 'How should we handle stakeholders who weren\'t consulted early in this process?', 'I\'d proactively reach out now with context, rather than waiting for them to raise concerns.'),
(@set_id, 11, 'What\'s your read on why the last initiative underperformed relative to projections?', 'I think we underestimated the change management required, not the strategy itself.'),
(@set_id, 12, 'How do we balance short-term deliverables with the longer-term architecture we want?', 'I\'d suggest a lightweight interim solution now, with the long-term build running in parallel.'),
(@set_id, 13, 'Can you defend the decision to deprioritize this feature to the broader team?', 'Yes — I can frame it around the data showing lower expected impact versus effort required.'),
(@set_id, 14, 'How do you plan to rebuild trust with the team after the missed deadline?', 'Full transparency about what went wrong, plus a revised plan with more conservative buffers.'),
(@set_id, 15, 'What would you do differently if we restarted this project from scratch?', 'I\'d invest more upfront in aligning expectations before any implementation work began.'),
(@set_id, 16, 'How do we ensure this decision doesn\'t just reflect the loudest voice in the room?', 'I\'d gather input asynchronously first, so quieter perspectives aren\'t drowned out in discussion.'),
(@set_id, 17, 'Can you outline the risk if we don\'t address this technical debt this quarter?', 'It compounds — future features will take proportionally longer to build safely.'),
(@set_id, 18, 'How should we message this organizational change to reduce anxiety on the team?', 'Lead with the \'why\' clearly, and be upfront about what\'s still undecided.'),
(@set_id, 19, 'What\'s your honest assessment of whether we\'re solving the right problem here?', 'I have some doubts — I think we\'re treating a symptom rather than the root cause.'),
(@set_id, 20, 'I appreciate how directly you engage with hard questions like these.', 'I\'d rather surface the hard parts early than let them surprise us later.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'friends';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hey! What are you doing this weekend?', 'I don\'t have any plans yet. Why?'),
(@set_id, 2, 'Do you want to watch a movie together?', 'Yes, that sounds fun! What movie?'),
(@set_id, 3, 'How about a comedy movie?', 'Sure, I love comedies.'),
(@set_id, 4, 'Should we order pizza too?', 'Yes, let\'s order pizza!'),
(@set_id, 5, 'What time should we meet?', 'Let\'s meet at six in the evening.'),
(@set_id, 6, 'Should I come to your house?', 'Yes, come to my house.'),
(@set_id, 7, 'Great, see you on Saturday!', 'See you then, I can\'t wait!'),
(@set_id, 8, 'This is going to be fun!', 'Yes, it will be a great weekend.'),
(@set_id, 9, 'Do you want to go to the park with me?', 'Yes, that sounds fun.'),
(@set_id, 10, 'Have you seen any good movies lately?', 'Yes, I saw a great one last week.'),
(@set_id, 11, 'Do you want to play a game together?', 'Yes, let\'s play cards.'),
(@set_id, 12, 'Are you free this Saturday?', 'Yes, I\'m free all day.'),
(@set_id, 13, 'Do you like my new haircut?', 'Yes, it looks really nice.'),
(@set_id, 14, 'Can I borrow your book?', 'Yes, of course, take it.'),
(@set_id, 15, 'Do you want to come to my birthday party?', 'Yes, I would love to come.'),
(@set_id, 16, 'Have you eaten dinner yet?', 'No, not yet, have you?'),
(@set_id, 17, 'Do you want to study together tomorrow?', 'Yes, that would be helpful.'),
(@set_id, 18, 'Can you help me move some furniture?', 'Yes, I can help this weekend.'),
(@set_id, 19, 'Do you want to try that new cafe?', 'Yes, I\'ve been wanting to go.'),
(@set_id, 20, 'See you at the party later!', 'See you there, bye!');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'friends';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hey, it\'s been forever! We should really catch up soon.', 'I agree, how about we grab dinner sometime this week?'),
(@set_id, 2, 'That works for me. How\'s everything going with you lately?', 'Pretty good, just been busy adjusting to a new work schedule.'),
(@set_id, 3, 'I totally get that. Any fun plans coming up?', 'Actually yes, I\'m planning a short trip with some friends next month.'),
(@set_id, 4, 'That sounds amazing, where are you guys thinking of going?', 'We\'re still deciding, but somewhere near the mountains probably.'),
(@set_id, 5, 'You\'ll have to send me pictures when you go.', 'Definitely, I\'ll make sure to share them with you.'),
(@set_id, 6, 'So what night works best for that dinner?', 'Thursday should work well for me, if that\'s okay with you.'),
(@set_id, 7, 'Thursday works perfectly. Same place as last time?', 'Sure, that place was great, let\'s go there again.'),
(@set_id, 8, 'Can\'t wait, it\'ll be good to properly catch up.', 'Me too, it feels like it\'s been ages.'),
(@set_id, 9, 'Do you think we should plan something for the group this weekend?', 'Yeah, it\'s been a while since everyone got together.'),
(@set_id, 10, 'How have things been with you lately, honestly?', 'A bit up and down, but overall I\'m doing okay.'),
(@set_id, 11, 'Do you remember that trip we took a few years back?', 'Of course, that\'s still one of my favorite memories with you all.'),
(@set_id, 12, 'What do you think about starting a monthly game night?', 'I love that idea, it\'d be a nice, low-key way to stay in touch.'),
(@set_id, 13, 'Have you talked to the rest of the group about the reunion?', 'Not yet, I was hoping we could plan it together first.'),
(@set_id, 14, 'Do you ever feel like we\'ve all grown in different directions?', 'Sometimes, but I think our core friendship has stayed pretty solid.'),
(@set_id, 15, 'What\'s something you\'ve been wanting to tell me but haven\'t had the chance?', 'Actually, I\'ve been thinking about making a big life change soon.'),
(@set_id, 16, 'How do you usually make time for friendships with such a busy schedule?', 'I block out specific time, otherwise it just keeps getting pushed back.'),
(@set_id, 17, 'Do you think it\'s okay for friendships to go through quiet periods?', 'Definitely, as long as you both know it\'ll pick back up naturally.'),
(@set_id, 18, 'What\'s a memory of us that always makes you laugh?', 'That time we got completely lost trying to find a shortcut home.'),
(@set_id, 19, 'Should we invite the new coworker to hang out with us sometime?', 'Yeah, that\'s a good idea, I think they\'d fit right in.'),
(@set_id, 20, 'I\'m really glad we still make time for each other.', 'Me too, this kind of friendship is hard to find.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'friends';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Honestly, I\'ve been meaning to talk to you about something that\'s been on my mind.', 'Of course, I\'m here, whatever it is, you can tell me.'),
(@set_id, 2, 'I\'ve been considering a pretty big career change and I\'m nervous about it.', 'That\'s completely understandable, big changes are scary but also exciting.'),
(@set_id, 3, 'Do you think I\'m making a mistake by leaving a stable job?', 'Not necessarily, stability isn\'t always the same thing as fulfillment.'),
(@set_id, 4, 'That\'s a good point, I hadn\'t thought about it that way.', 'I think you should trust yourself, you\'ve clearly thought this through carefully.'),
(@set_id, 5, 'I appreciate that, it really helps hearing your perspective on this.', 'That\'s what friends are for, I\'ll support whatever you decide.'),
(@set_id, 6, 'Thanks, it means a lot to have someone to talk this through with.', 'Anytime, and let\'s celebrate properly once you take the leap.'),
(@set_id, 7, 'I\'ll definitely hold you to that celebration.', 'Good, I\'m already thinking about where we should go.'),
(@set_id, 8, 'This conversation really helped me feel more confident.', 'I\'m really glad, you deserve to feel good about this decision.'),
(@set_id, 9, 'Do you think friendships require effort in the same way romantic relationships do?', 'Absolutely, I think we underestimate how much intentionality lasting friendships actually need.'),
(@set_id, 10, 'How do you handle it when a close friend\'s values start to diverge from yours?', 'I try to separate disagreement from disconnection — we can differ and still stay close.'),
(@set_id, 11, 'What\'s something you\'ve learned about setting boundaries within friendships?', 'That honesty early on prevents resentment from quietly building up over time.'),
(@set_id, 12, 'Do you think it\'s possible to outgrow a friendship without it being anyone\'s fault?', 'Yes, sometimes people just grow in different directions, and that\'s genuinely okay.'),
(@set_id, 13, 'How do you navigate supporting a friend through something you don\'t fully understand?', 'I focus on listening well rather than trying to relate through my own experiences.'),
(@set_id, 14, 'What\'s a hard truth a friend once told you that you\'re grateful for now?', 'That I was avoiding a decision out of fear, not genuine uncertainty.'),
(@set_id, 15, 'Do you think vulnerability is the foundation of deep friendship, or something else?', 'Vulnerability matched with consistency — one without the other doesn\'t build lasting trust.'),
(@set_id, 16, 'How do you maintain long-distance friendships that used to be daily interactions?', 'Regular, scheduled catch-ups, even short ones, keep the connection from fading.'),
(@set_id, 17, 'What\'s your view on staying friends with people from very different life stages than you?', 'I think it\'s valuable — different perspectives keep me from a narrow view of life.'),
(@set_id, 18, 'How do you handle jealousy or comparison creeping into a close friendship?', 'I name it honestly to myself first, then choose to celebrate rather than compare.'),
(@set_id, 19, 'What\'s the most important quality you look for in a lasting friendship?', 'Reliability, honestly — showing up consistently matters more than grand gestures.'),
(@set_id, 20, 'This conversation reminded me how much I value our friendship.', 'Same here, conversations like this don\'t happen with just anyone.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'at-home';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'What are you doing right now?', 'I am cleaning the kitchen.'),
(@set_id, 2, 'Do you need any help?', 'Yes, can you wash the dishes?'),
(@set_id, 3, 'Sure, I can do that.', 'Thank you, I really appreciate it.'),
(@set_id, 4, 'What are we having for dinner?', 'We are having rice and vegetables.'),
(@set_id, 5, 'That sounds delicious.', 'Yes, it will be ready soon.'),
(@set_id, 6, 'Can you set the table, please?', 'Yes, I will set the table now.'),
(@set_id, 7, 'Dinner is ready!', 'Great, I\'m coming right now.'),
(@set_id, 8, 'Let\'s eat together.', 'Yes, let\'s enjoy our meal.'),
(@set_id, 9, 'Can you turn off the lights, please?', 'Yes, I\'ll turn them off now.'),
(@set_id, 10, 'Is the door locked?', 'Yes, I already locked it.'),
(@set_id, 11, 'Can you water the plants today?', 'Yes, I\'ll do it after lunch.'),
(@set_id, 12, 'Did you take out the trash?', 'Yes, I took it out this morning.'),
(@set_id, 13, 'Can we watch a movie tonight?', 'Yes, that sounds like a great idea.'),
(@set_id, 14, 'Is the laundry finished yet?', 'Almost, it needs ten more minutes.'),
(@set_id, 15, 'Can you turn down the volume a bit?', 'Sure, sorry about that.'),
(@set_id, 16, 'Did you feed the cat?', 'Yes, I fed her an hour ago.'),
(@set_id, 17, 'Can we order pizza tonight?', 'Yes, let\'s order pizza.'),
(@set_id, 18, 'Is it okay if I use the kitchen now?', 'Yes, go ahead, it\'s free.'),
(@set_id, 19, 'Can you help me fix this chair?', 'Yes, let me take a look.'),
(@set_id, 20, 'Good night, see you tomorrow.', 'Good night, sleep well.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'at-home';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Hey, could you help me tidy up before guests arrive?', 'Sure, I\'ll start with the living room right away.'),
(@set_id, 2, 'Thanks, I\'ll handle the kitchen and set out some snacks.', 'Sounds good, what time are they expected to arrive?'),
(@set_id, 3, 'They should be here around six thirty.', 'Okay, that gives us plenty of time to get everything ready.'),
(@set_id, 4, 'Do you think we have enough seating for everyone?', 'I think so, but let\'s bring in a couple extra chairs just in case.'),
(@set_id, 5, 'Good idea, I\'ll grab those from the storage room.', 'Thanks, I\'ll finish setting the table while you do that.'),
(@set_id, 6, 'Should we put on some music before they arrive?', 'Yes, that would really help set a nice atmosphere.'),
(@set_id, 7, 'I think everything looks great now.', 'It really does, I think we\'re all set for tonight.'),
(@set_id, 8, 'Perfect, I hear the doorbell already.', 'Right on time, let\'s go welcome them in.'),
(@set_id, 9, 'Do you think we should repaint the living room this year?', 'I\'ve been thinking the same thing, maybe a lighter color this time.'),
(@set_id, 10, 'How do we usually split chores around here?', 'Roughly evenly, though it helps when we plan the week ahead.'),
(@set_id, 11, 'Should we set a budget for redecorating the bedroom?', 'Yes, that\'s a good idea, let\'s figure out a reasonable number.'),
(@set_id, 12, 'Do you think we\'re using this extra room efficiently?', 'Not really, it\'s mostly just storage right now, we should rethink it.'),
(@set_id, 13, 'How do you feel about hosting a small get-together here next month?', 'I\'m up for it, as long as we tidy up the living room beforehand.'),
(@set_id, 14, 'Should we invest in better lighting for the kitchen?', 'Definitely, the current lighting makes cooking harder than it needs to be.'),
(@set_id, 15, 'Do you want to try growing a few herbs on the balcony?', 'Yes, that sounds nice, basil and mint would be a good start.'),
(@set_id, 16, 'How do you usually unwind once you\'re home for the evening?', 'I like to make tea and just sit quietly for a while first.'),
(@set_id, 17, 'Should we set aside a weekend to properly organize the garage?', 'Yes, it\'s overdue, let\'s pick a date before it piles up more.'),
(@set_id, 18, 'Do you think we need a better system for grocery shopping?', 'Probably, a shared list would stop us from forgetting things.'),
(@set_id, 19, 'How do you feel about the new furniture arrangement so far?', 'I actually really like it, the room feels more open now.'),
(@set_id, 20, 'This house is really starting to feel like home.', 'It is, we\'ve put a lot of thought into it.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'at-home';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'I\'ve been thinking we should rearrange the living room for better flow.', 'That\'s a good idea, the current layout does feel a bit cramped.'),
(@set_id, 2, 'Maybe we could move the sofa closer to the window for more light.', 'I like that idea, it would really open up the space visually.'),
(@set_id, 3, 'We could also consider getting rid of a few things we don\'t use anymore.', 'Agreed, decluttering has been on my mind for a while now too.'),
(@set_id, 4, 'How do you usually decide what to keep and what to donate?', 'I try to think about whether I\'ve used it in the past year.'),
(@set_id, 5, 'That\'s a practical approach, I should apply that to my closet too.', 'Definitely, it makes the whole process feel a lot less overwhelming.'),
(@set_id, 6, 'Should we set aside this weekend to finally tackle it together?', 'That sounds like a solid plan, let\'s block out Saturday morning for it.'),
(@set_id, 7, 'Great, I\'ll grab some boxes and bags in advance.', 'Perfect, I\'ll start sorting through the shelves beforehand as well.'),
(@set_id, 8, 'I think our home is going to feel so much better afterward.', 'I\'m sure it will, I\'m actually looking forward to it now.'),
(@set_id, 9, 'Do you think our home reflects who we actually are, or just habit and convenience?', 'Mostly habit, honestly — I think we\'ve settled rather than intentionally designed it.'),
(@set_id, 10, 'How do you think our living space affects our daily mood and productivity?', 'More than we usually credit — clutter especially seems to quietly drain my focus.'),
(@set_id, 11, 'Should we reconsider how much space we dedicate to things we rarely use?', 'Yes, I think we\'re holding onto a lot out of sentiment rather than necessity.'),
(@set_id, 12, 'What would it take for this home to feel genuinely restorative rather than just functional?', 'Probably fewer possessions and more intentional space to just sit and think.'),
(@set_id, 13, 'Do you think shared domestic responsibilities reveal deeper relationship dynamics?', 'Definitely — how we handle chores says a lot about fairness and communication overall.'),
(@set_id, 14, 'How do you feel about the balance between personal space and shared space at home?', 'I think we could use clearer boundaries, especially since we both work from here now.'),
(@set_id, 15, 'What\'s a home habit we\'ve built that you\'re genuinely proud of?', 'How consistently we sit down together for dinner, even on busy days.'),
(@set_id, 16, 'Do you think minimalism would actually suit how we live, or is it impractical for us?', 'Some version of it would help, though full minimalism might be unrealistic for our lifestyle.'),
(@set_id, 17, 'How do we ensure this space keeps evolving with us instead of staying static?', 'Regular small check-ins, rather than waiting for something to feel completely wrong first.'),
(@set_id, 18, 'What\'s something about how we live that a guest probably wouldn\'t guess from outside?', 'How much we actually plan and negotiate to keep things running this smoothly.'),
(@set_id, 19, 'Do you think a home should be designed around aesthetics or purely function?', 'A balance, but I\'d lean toward function first, aesthetics can follow from that.'),
(@set_id, 20, 'This turned into a surprisingly deep conversation about something so ordinary.', 'It did — home says more about us than we usually stop to notice.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'asking-directions';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Excuse me, can I help you?', 'Yes, please. Where is the train station?'),
(@set_id, 2, 'Go straight, then turn left.', 'Turn left, okay. Is it far?'),
(@set_id, 3, 'No, it\'s about five minutes away.', 'Thank you very much for your help.'),
(@set_id, 4, 'You\'re welcome. Do you need anything else?', 'Yes, is there a bank nearby too?'),
(@set_id, 5, 'Yes, it\'s next to the station.', 'Great, thank you so much.'),
(@set_id, 6, 'No problem at all.', 'Have a nice day!'),
(@set_id, 7, 'You too, safe travels!', 'Thank you, goodbye!'),
(@set_id, 8, 'Goodbye!', 'Bye!'),
(@set_id, 9, 'Excuse me, where is the post office?', 'It\'s two blocks from here.'),
(@set_id, 10, 'Is this the right way to the museum?', 'Yes, keep walking straight.'),
(@set_id, 11, 'How far is the nearest hospital?', 'It\'s about ten minutes by car.'),
(@set_id, 12, 'Can I walk there, or should I take a bus?', 'You can walk, it\'s not far.'),
(@set_id, 13, 'Where can I catch a taxi?', 'There\'s a stand right around the corner.'),
(@set_id, 14, 'Is there a park near here?', 'Yes, just past the school.'),
(@set_id, 15, 'Which direction is downtown?', 'It\'s that way, to the north.'),
(@set_id, 16, 'Is the market open right now?', 'Yes, it should be open until six.'),
(@set_id, 17, 'Do you know where the bus stop is?', 'Yes, it\'s right in front of the bank.'),
(@set_id, 18, 'How do I get to the highway from here?', 'Turn right, then follow the signs.'),
(@set_id, 19, 'Is there a shortcut through the park?', 'Yes, that\'s actually much faster.'),
(@set_id, 20, 'Thanks a lot for the directions!', 'No problem, safe travels!');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'asking-directions';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Excuse me, you look a bit lost. Can I help you find something?', 'Yes, actually, I\'m trying to find the nearest pharmacy.'),
(@set_id, 2, 'Sure, there\'s one about two blocks from here, near the corner cafe.', 'Great, could you tell me which direction that is exactly?'),
(@set_id, 3, 'Just head straight down this street and turn right at the traffic light.', 'Okay, straight and then right at the light, got it.'),
(@set_id, 4, 'Exactly. It should take you about seven or eight minutes on foot.', 'That\'s perfect, thank you so much for the detailed directions.'),
(@set_id, 5, 'No problem. Are you visiting the area for the first time?', 'Yes, I just arrived yesterday, so I\'m still getting oriented.'),
(@set_id, 6, 'Welcome then! Let me know if you need help finding anything else.', 'Actually, is there a good place nearby for lunch too?'),
(@set_id, 7, 'There\'s a great little bistro just past the pharmacy, can\'t miss it.', 'Perfect, I\'ll check that out after I stop by the pharmacy.'),
(@set_id, 8, 'Enjoy your time exploring the area!', 'Thank you, I really appreciate your help today.'),
(@set_id, 9, 'Excuse me, I seem to have taken a wrong turn — can you help me get back on track?', 'Sure, where exactly are you trying to get to?'),
(@set_id, 10, 'Is there a more scenic route to the waterfront, even if it takes a bit longer?', 'Yes, actually, if you head along the river path it\'s much nicer.'),
(@set_id, 11, 'Do you know if there\'s a shortcut that avoids the main traffic area?', 'There is, cutting through the side streets saves quite a bit of time.'),
(@set_id, 12, 'How reliable is the public transport around here for getting downtown?', 'Pretty reliable, buses run every fifteen minutes or so during the day.'),
(@set_id, 13, 'Is it safe to walk through this area after dark?', 'Generally yes, though I\'d stick to the main streets just to be safe.'),
(@set_id, 14, 'Do you know somewhere nearby I could stop and check my phone for directions?', 'There\'s a cafe just ahead with plenty of seating and wifi.'),
(@set_id, 15, 'Which exit should I take if I\'m heading toward the old town?', 'Take the second exit, then follow the signs for the historic district.'),
(@set_id, 16, 'Is parking easy to find near the city center?', 'It can be tricky, especially on weekends — I\'d recommend a parking app.'),
(@set_id, 17, 'How long would it take to walk there instead of taking a cab?', 'Probably about twenty-five minutes, depending on how fast you walk.'),
(@set_id, 18, 'Do you know if that road is closed for construction right now?', 'It was last week, but I believe it\'s reopened since then.'),
(@set_id, 19, 'Is there a landmark I should look out for along the way?', 'Yes, once you see the big clock tower, you\'re almost there.'),
(@set_id, 20, 'You\'ve been incredibly helpful, thank you for taking the time.', 'Happy to help, hope the rest of your day goes smoothly.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'asking-directions';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'You seem to be checking your map quite a bit, need any help getting oriented?', 'Yes, actually, I\'m trying to figure out the quickest route to the museum district.'),
(@set_id, 2, 'Ah, that\'s a bit tricky by foot, but the metro would get you there in about fifteen minutes.', 'That sounds efficient, could you point me toward the nearest station?'),
(@set_id, 3, 'Of course, it\'s just around this corner, look for the blue sign overhead.', 'Got it, and which line should I take once I\'m inside?'),
(@set_id, 4, 'Take the green line heading north, and get off after three stops.', 'Perfect, three stops north on the green line, that\'s easy to remember.'),
(@set_id, 5, 'Once you exit, the museum entrance is right across the plaza.', 'That\'s incredibly helpful, thank you for such clear directions.'),
(@set_id, 6, 'No trouble at all, are you planning to explore other parts of the city too?', 'Yes, I\'m hoping to visit the old town district later this afternoon.'),
(@set_id, 7, 'That area is beautiful, though it can get quite crowded by evening.', 'Good to know, I\'ll try to head over there a bit earlier then.'),
(@set_id, 8, 'Sounds like a solid plan, enjoy the rest of your day exploring.', 'Thank you so much, I really appreciate all your help today.'),
(@set_id, 9, 'I\'m trying to navigate around today\'s road closures — is there a route you\'d personally recommend?', 'I\'d suggest looping around via the ring road, it avoids most of the disruption.'),
(@set_id, 10, 'How reliable would you say GPS navigation is in this particular part of the city?', 'Fairly unreliable, honestly, the older streets confuse most mapping apps.'),
(@set_id, 11, 'Do you think the city\'s public transit system adequately serves this neighborhood?', 'Not really — there\'s a noticeable gap in coverage compared to more central areas.'),
(@set_id, 12, 'What\'s the most efficient way to combine walking and transit to reach the far side of town?', 'I\'d walk to the main station, then take the express line, it\'s faster than transferring twice.'),
(@set_id, 13, 'Is there a route that\'s more accessible for someone with mobility difficulties?', 'Yes, there\'s a level path along the main avenue that avoids all the stairs.'),
(@set_id, 14, 'How has this area\'s infrastructure changed since the redevelopment a few years back?', 'Significantly — a lot of the older shortcuts have been replaced with pedestrian zones.'),
(@set_id, 15, 'Do you think signage in this district is genuinely intuitive for newcomers?', 'Not particularly, it relies a lot on local knowledge that visitors just don\'t have.'),
(@set_id, 16, 'What\'s the best strategy for avoiding rush hour congestion around here?', 'Leaving about thirty minutes earlier or later makes a surprisingly large difference.'),
(@set_id, 17, 'Is there a route that avoids the tourist-heavy streets entirely?', 'Yes, the back streets running parallel are much quieter, if a bit longer.'),
(@set_id, 18, 'How would you compare navigating this city on foot versus by bike?', 'By bike is faster overall, though foot traffic areas can get genuinely congested.'),
(@set_id, 19, 'Do you think this city could benefit from clearer wayfinding systems?', 'Absolutely, especially near major transit hubs where confusion seems most common.'),
(@set_id, 20, 'Your local knowledge has honestly saved me a significant amount of time today.', 'Glad it helped — this city takes a while to really learn your way around.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'doctor-visit';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Good morning. What seems to be the problem?', 'I have a headache and a sore throat.'),
(@set_id, 2, 'How long have you had these symptoms?', 'I\'ve had them for two days.'),
(@set_id, 3, 'Do you have a fever?', 'Yes, a little fever.'),
(@set_id, 4, 'I will check your temperature now.', 'Okay, thank you, doctor.'),
(@set_id, 5, 'You have a mild cold. Rest and drink water.', 'Okay, I will rest and drink more water.'),
(@set_id, 6, 'I will give you some medicine.', 'Thank you. How many times a day?'),
(@set_id, 7, 'Take it twice a day after meals.', 'Okay, I understand. Thank you.'),
(@set_id, 8, 'Get well soon!', 'Thank you, doctor. Goodbye.'),
(@set_id, 9, 'Where does it hurt exactly?', 'It hurts here, in my stomach.'),
(@set_id, 10, 'Have you taken any medicine already?', 'No, I haven\'t taken anything yet.'),
(@set_id, 11, 'Are you allergic to any medicines?', 'No, I don\'t have any allergies.'),
(@set_id, 12, 'Do you have any other symptoms?', 'Yes, I also feel very tired.'),
(@set_id, 13, 'Have you eaten anything today?', 'Yes, I had breakfast this morning.'),
(@set_id, 14, 'Do you smoke or drink alcohol?', 'No, I don\'t do either.'),
(@set_id, 15, 'I\'ll write you a prescription now.', 'Thank you, doctor.'),
(@set_id, 16, 'Please come back if it gets worse.', 'Okay, I will do that.'),
(@set_id, 17, 'Do you need a doctor\'s note for work?', 'Yes, that would be helpful, thank you.'),
(@set_id, 18, 'How long should I take this medicine?', 'You should take it for five days.'),
(@set_id, 19, 'Should I avoid any food?', 'Yes, please avoid spicy food for now.'),
(@set_id, 20, 'Take care and rest well.', 'Thank you, I will.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'doctor-visit';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Good morning, what brings you in today?', 'I\'ve been having lower back pain for the past week.'),
(@set_id, 2, 'I see. Did it start after any specific activity?', 'I think it started after I lifted something heavy at home.'),
(@set_id, 3, 'That\'s often the cause. Is the pain constant or does it come and go?', 'It comes and goes, but it gets worse when I sit for too long.'),
(@set_id, 4, 'Understood. Have you tried any pain relief so far?', 'Just some over-the-counter pain medication, but it hasn\'t helped much.'),
(@set_id, 5, 'I\'d recommend some light stretching and a warm compress for now.', 'Okay, should I avoid exercise completely until it improves?'),
(@set_id, 6, 'Not entirely, gentle movement is actually better than staying still.', 'That\'s good to know, I was worried resting completely was necessary.'),
(@set_id, 7, 'I\'ll also refer you for a quick X-ray just to be safe.', 'That sounds reasonable, thank you for being thorough about it.'),
(@set_id, 8, 'We\'ll get the results back within a couple of days.', 'Great, thank you for taking the time to explain everything, doctor.'),
(@set_id, 9, 'Can you describe when the pain tends to get worse?', 'It usually gets worse in the evening, after a long day standing.'),
(@set_id, 10, 'Have you noticed any pattern with what triggers these symptoms?', 'It seems to happen more after I eat certain heavy meals.'),
(@set_id, 11, 'Are you currently taking any other medications regularly?', 'Just a daily vitamin, nothing else on a regular basis.'),
(@set_id, 12, 'How has your sleep been over the past couple of weeks?', 'Not great, honestly, I\'ve been waking up a few times a night.'),
(@set_id, 13, 'Would you say your stress levels have changed recently?', 'Yes, work has been more demanding than usual lately.'),
(@set_id, 14, 'Have you tried any home remedies before coming in today?', 'Just rest and staying hydrated, but it hasn\'t fully helped.'),
(@set_id, 15, 'I\'d like to order a few basic tests just to rule things out.', 'That sounds reasonable, I\'d rather know for sure.'),
(@set_id, 16, 'How would you rate the pain on a scale from one to ten?', 'I\'d say around a six, it\'s noticeable but manageable most of the day.'),
(@set_id, 17, 'Do you have any family history relevant to these symptoms?', 'Not that I\'m aware of, no one else in my family has had this.'),
(@set_id, 18, 'I\'d recommend following up in two weeks if symptoms persist.', 'Understood, I\'ll keep track of how things progress until then.'),
(@set_id, 19, 'Is there anything else you\'d like to mention before we wrap up?', 'No, I think that covers everything I wanted to ask about.'),
(@set_id, 20, 'Please don\'t hesitate to reach out if anything changes.', 'I appreciate that, thank you for being so thorough today.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'doctor-visit';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'So tell me a bit more about what\'s been going on lately.', 'I\'ve noticed I\'ve been feeling unusually fatigued for the past few weeks.'),
(@set_id, 2, 'Has this fatigue been affecting your daily activities significantly?', 'Yes, even simple tasks feel more exhausting than they normally would.'),
(@set_id, 3, 'Have you noticed any changes in sleep, appetite, or stress levels recently?', 'My sleep has been irregular, and I\'ve definitely been under more stress at work.'),
(@set_id, 4, 'That could certainly be contributing. Let\'s run a few basic blood tests to rule things out.', 'That sounds like a good idea, I\'d rather be thorough about it.'),
(@set_id, 5, 'In the meantime, I\'d suggest trying to establish a more consistent sleep schedule.', 'I\'ll try, though it\'s been difficult with everything going on lately.'),
(@set_id, 6, 'Completely understandable, even small consistent changes can help though.', 'That\'s reassuring, I\'ll aim for at least a fixed bedtime this week.'),
(@set_id, 7, 'We\'ll review your test results together once they\'re back.', 'Thank you, I appreciate you taking my concerns seriously.'),
(@set_id, 8, 'Of course, your wellbeing is what matters most here.', 'I really appreciate that, thank you for your time today, doctor.'),
(@set_id, 9, 'Can you walk me through how these symptoms have progressed over the past month?', 'They started mildly, but the frequency has noticeably increased over the last two weeks.'),
(@set_id, 10, 'How would you characterize the impact this has had on your daily functioning?', 'It\'s affected my concentration at work more than any physical limitation, honestly.'),
(@set_id, 11, 'Have you noticed any correlation between symptom severity and specific stressors?', 'Yes, it does seem to flare up during particularly demanding periods at work.'),
(@set_id, 12, 'Given your history, I\'d like to rule out a few less common possibilities as well.', 'That makes sense, I\'d rather be thorough than second-guess this later.'),
(@set_id, 13, 'How do you feel about starting a treatment plan versus monitoring for now?', 'I\'m open to starting treatment, especially if it prevents things from worsening.'),
(@set_id, 14, 'What are your thoughts on incorporating lifestyle changes alongside any medication?', 'I\'m definitely willing to, I\'d like to address the root cause where possible.'),
(@set_id, 15, 'Are there any concerns you have about potential side effects of this treatment?', 'Mainly around how it might affect my energy levels during work hours.'),
(@set_id, 16, 'How do you typically respond to new medications in terms of side effects?', 'Generally well, though I\'ve had mild reactions to certain ones before.'),
(@set_id, 17, 'I\'d like to schedule a follow-up to reassess after a few weeks on this plan.', 'That works for me, I\'d like to track my progress closely as well.'),
(@set_id, 18, 'What questions do you have about how this diagnosis might affect your long-term health?', 'Mainly whether this is something I\'ll need to manage indefinitely or just short-term.'),
(@set_id, 19, 'Is there any aspect of this treatment plan that feels unclear or concerning to you?', 'Just the dosage adjustment schedule — could you clarify that part again?'),
(@set_id, 20, 'I really appreciate how thoroughly you\'ve explained everything today.', 'Of course, I\'d rather you feel fully informed about your own care.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'future-plans';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'What are your plans for next week?', 'I will visit my grandmother next week.'),
(@set_id, 2, 'That sounds nice. What will you do there?', 'We will cook and talk together.'),
(@set_id, 3, 'Do you have any plans for next month?', 'Yes, I will start a new class next month.'),
(@set_id, 4, 'What class will you take?', 'I will take a cooking class.'),
(@set_id, 5, 'That\'s exciting! What about next year?', 'Next year, I want to travel to Italy.'),
(@set_id, 6, 'That sounds wonderful. Why Italy?', 'I love Italian food and history.'),
(@set_id, 7, 'I hope your plans go well!', 'Thank you, I\'m really excited.'),
(@set_id, 8, 'Good luck with everything!', 'Thank you so much.'),
(@set_id, 9, 'What will you do this weekend?', 'I will clean my house this weekend.'),
(@set_id, 10, 'Do you have plans tonight?', 'Yes, I will meet a friend tonight.'),
(@set_id, 11, 'What will you study next year?', 'I will study business next year.'),
(@set_id, 12, 'Will you travel this summer?', 'Yes, I will visit my cousins.'),
(@set_id, 13, 'What job do you want in the future?', 'I want to become a teacher.'),
(@set_id, 14, 'Will you buy a new phone soon?', 'Yes, I will buy one next month.'),
(@set_id, 15, 'Do you plan to learn a new skill?', 'Yes, I want to learn to swim.'),
(@set_id, 16, 'Will you move to a new house?', 'Yes, we are moving next year.'),
(@set_id, 17, 'What will you do after graduation?', 'I will look for a job.'),
(@set_id, 18, 'Do you have any goals for this year?', 'Yes, I want to save more money.'),
(@set_id, 19, 'Will you celebrate your birthday this year?', 'Yes, with a small party at home.'),
(@set_id, 20, 'I hope all your plans come true!', 'Thank you so much!');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'future-plans';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'So what\'s next for you after finishing this project?', 'I\'m planning to take a short break before starting something new.'),
(@set_id, 2, 'That sounds well deserved. Any ideas what\'s next professionally?', 'I\'m actually considering switching to a role with more design work.'),
(@set_id, 3, 'That\'s a big shift, what\'s motivating that change?', 'I\'ve realized I enjoy the creative side of projects much more.'),
(@set_id, 4, 'That makes sense. Are you planning to take any courses to prepare?', 'Yes, I\'m enrolling in an online design course next month.'),
(@set_id, 5, 'That\'s a great step. Do you have a timeline in mind?', 'I\'m hoping to make the transition within the next six months.'),
(@set_id, 6, 'Sounds achievable with the right plan in place.', 'I think so too, as long as I stay consistent with learning.'),
(@set_id, 7, 'What about personal plans, anything exciting coming up?', 'Yes, I\'m planning a trip with friends later this year.'),
(@set_id, 8, 'That sounds like a nice balance between work and fun.', 'Exactly, I\'m trying to make more time for both.'),
(@set_id, 9, 'Do you have a five-year plan, or do you prefer to stay flexible?', 'A rough idea, but I try not to lock myself into anything too rigid.'),
(@set_id, 10, 'What\'s a goal you\'re currently working toward outside of work?', 'I\'m training for a half marathon later this year.'),
(@set_id, 11, 'How do you decide which opportunities are worth pursuing right now?', 'I ask whether it aligns with where I want to be in a couple of years.'),
(@set_id, 12, 'Do you see yourself staying in this city long-term?', 'I\'m not sure yet, it depends a lot on where my career takes me.'),
(@set_id, 13, 'What\'s something you\'ve been putting off that you\'d like to finally start?', 'Learning to play an instrument, I keep saying I\'ll start next month.'),
(@set_id, 14, 'How do you balance planning for the future with enjoying the present?', 'I try to set goals without letting them overshadow everyday enjoyment.'),
(@set_id, 15, 'What\'s a skill you think will be valuable for your future career?', 'Adaptability, honestly, more than any single technical skill.'),
(@set_id, 16, 'Do you have any plans to further your education down the line?', 'Possibly, I\'m considering a certification program in a year or two.'),
(@set_id, 17, 'What does your ideal life look like ten years from now?', 'Stable work I enjoy, close relationships, and time for travel.'),
(@set_id, 18, 'How do you stay accountable to your own goals?', 'I check in with myself monthly and adjust if something isn\'t working.'),
(@set_id, 19, 'Are there any big financial goals you\'re working toward?', 'Yes, I\'m saving toward a down payment on a place of my own.'),
(@set_id, 20, 'It sounds like you\'ve really thought this through.', 'I try to, though plans definitely shift along the way too.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'future-plans';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Where do you see your career heading over the next several years?', 'I\'m hoping to move into a leadership position where I can shape strategy directly.'),
(@set_id, 2, 'That\'s an ambitious goal. What steps are you taking to get there?', 'I\'m actively seeking mentorship and taking on cross-functional projects to build experience.'),
(@set_id, 3, 'That\'s a smart approach. Do you have a specific timeline for this transition?', 'Roughly two to three years, though I\'m staying flexible depending on opportunities.'),
(@set_id, 4, 'Flexibility seems wise given how quickly industries shift these days.', 'Exactly, I\'d rather adapt the plan than force a rigid timeline.'),
(@set_id, 5, 'Are there any skills you feel you still need to develop?', 'Definitely, I need to strengthen my public speaking and negotiation abilities.'),
(@set_id, 6, 'Those are valuable skills for leadership roles indeed.', 'I\'ve actually signed up for a workshop to start working on both.'),
(@set_id, 7, 'That initiative will likely pay off significantly down the line.', 'I hope so, I\'m trying to be intentional rather than just reactive about my growth.'),
(@set_id, 8, 'It sounds like you have a clear and thoughtful vision ahead.', 'Thank you, it\'s taken a lot of reflection to get this clarity.'),
(@set_id, 9, 'How do you approach planning for a future that feels increasingly unpredictable?', 'I focus on building flexible skills rather than rigid, specific plans.'),
(@set_id, 10, 'Do you think setting long-term goals still makes sense given how quickly industries change?', 'I think direction still matters, even if the specific path has to keep adjusting.'),
(@set_id, 11, 'What\'s a long-held plan you eventually let go of, and how did that feel?', 'Letting go of a specific career path felt like failure at first, but it opened better options.'),
(@set_id, 12, 'How do you weigh security against ambition when planning your future?', 'I try to secure a baseline of stability, then take calculated risks beyond that.'),
(@set_id, 13, 'Do you think it\'s healthier to plan around goals or around values?', 'Values, ultimately — goals shift, but values tend to keep decisions consistent.'),
(@set_id, 14, 'What\'s your view on the pressure to have everything figured out by a certain age?', 'I think it\'s largely manufactured — meaningful clarity often comes later than expected.'),
(@set_id, 15, 'How do you evaluate whether a future goal is genuinely yours or externally influenced?', 'I ask whether I\'d still want it if no one else would ever know about it.'),
(@set_id, 16, 'Do you plan differently for your career versus your personal life?', 'Yes, career plans are more structured, personal life stays intentionally looser.'),
(@set_id, 17, 'What\'s a future scenario you\'re actively preparing for that feels uncertain?', 'How automation might reshape my industry over the next decade.'),
(@set_id, 18, 'How do you maintain motivation toward goals that are still years away?', 'I break them into smaller milestones that give a sense of progress sooner.'),
(@set_id, 19, 'Do you think revisiting and revising your goals regularly is a strength or a weakness?', 'A strength, definitely — rigid adherence to outdated goals rarely serves anyone well.'),
(@set_id, 20, 'This conversation has genuinely clarified some of my own thinking about the future.', 'Same here, it\'s helpful to say these things out loud occasionally.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'past-experiences';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'What did you do yesterday?', 'I went shopping with my sister yesterday.'),
(@set_id, 2, 'What did you buy?', 'I bought a new pair of shoes.'),
(@set_id, 3, 'Did you do anything last weekend?', 'Yes, I visited my parents last weekend.'),
(@set_id, 4, 'That sounds nice. How was it?', 'It was really nice, we had a big dinner.'),
(@set_id, 5, 'What was the best trip you ever took?', 'My best trip was to Goa two years ago.'),
(@set_id, 6, 'What did you do there?', 'I swam in the sea and ate great food.'),
(@set_id, 7, 'Sounds like a great memory!', 'Yes, it was one of my favorite trips.'),
(@set_id, 8, 'Thanks for sharing that story!', 'You\'re welcome, it was fun to talk about.'),
(@set_id, 9, 'Where did you grow up?', 'I grew up in a small town.'),
(@set_id, 10, 'What was your first job?', 'My first job was at a bookstore.'),
(@set_id, 11, 'Did you enjoy your school days?', 'Yes, I had a great time at school.'),
(@set_id, 12, 'What did you do last summer?', 'I traveled with my family.'),
(@set_id, 13, 'Have you ever lived in another city?', 'Yes, I lived in Mumbai for two years.'),
(@set_id, 14, 'What was your favorite toy as a child?', 'I loved my old toy car.'),
(@set_id, 15, 'Did you have a pet growing up?', 'Yes, we had a dog named Rocky.'),
(@set_id, 16, 'What is a happy memory from your childhood?', 'Playing cricket with my cousins.'),
(@set_id, 17, 'Have you ever won a competition?', 'Yes, I won a school drawing contest.'),
(@set_id, 18, 'What was your first car?', 'My first car was a small blue hatchback.'),
(@set_id, 19, 'Did you learn to swim as a child?', 'Yes, my father taught me.'),
(@set_id, 20, 'Thanks for sharing these memories.', 'You\'re welcome, it was fun to remember.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'past-experiences';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'What\'s a memory from your childhood that still makes you smile?', 'I remember building sandcastles on the beach every summer with my cousins.'),
(@set_id, 2, 'That sounds wonderful. Did you go to the same place every year?', 'Yes, it became a bit of a family tradition for almost a decade.'),
(@set_id, 3, 'Traditions like that are really special. What changed it eventually?', 'Everyone got busier with work and school, so it slowly stopped happening.'),
(@set_id, 4, 'That\'s a common story, unfortunately. Do you miss those trips?', 'I do, actually, those were some of the simplest and happiest times.'),
(@set_id, 5, 'Have you thought about starting something similar again?', 'Yes, I\'ve actually been trying to plan a reunion trip for next year.'),
(@set_id, 6, 'That\'s a lovely idea, I hope it comes together.', 'Me too, it would mean a lot to reconnect with everyone.'),
(@set_id, 7, 'Is there anything from your past you\'d do differently?', 'I probably would have spent less time worrying and more time enjoying moments.'),
(@set_id, 8, 'That\'s a really thoughtful realization.', 'It took me a while to see it that way, honestly.'),
(@set_id, 9, 'What\'s an experience that taught you a lot about resilience?', 'Going through a tough job loss and rebuilding from there taught me a lot.'),
(@set_id, 10, 'Was there a teacher or mentor who really shaped who you are?', 'Yes, a high school teacher who genuinely believed in me when I doubted myself.'),
(@set_id, 11, 'What\'s a decision from your past you\'re especially glad you made?', 'Choosing to study abroad, even though it felt risky at the time.'),
(@set_id, 12, 'Have you ever had an experience that completely changed your perspective?', 'Yes, volunteering abroad shifted how I think about privilege and gratitude.'),
(@set_id, 13, 'What\'s a failure from your past that you now see differently?', 'Failing a big exam, which pushed me to develop much better study habits.'),
(@set_id, 14, 'Do you have a favorite memory from your first job?', 'Yes, the small team celebrating our first successful project together.'),
(@set_id, 15, 'What\'s something you experienced that others might find surprising?', 'I actually lived without internet access for a summer, and it was oddly refreshing.'),
(@set_id, 16, 'Have your past experiences shaped how you approach relationships now?', 'Definitely, I value honesty far more after a few difficult past experiences.'),
(@set_id, 17, 'What\'s a risk you took in the past that didn\'t work out as planned?', 'Starting a small business that eventually didn\'t succeed, but taught me a lot.'),
(@set_id, 18, 'How do you usually reflect on difficult past experiences?', 'I try to extract a lesson rather than dwell on the difficulty itself.'),
(@set_id, 19, 'What\'s a tradition from your past you\'d like to continue?', 'Sunday family dinners, they always felt grounding growing up.'),
(@set_id, 20, 'It\'s clear these experiences have really shaped who you are.', 'They have, each one taught me something I still carry today.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'past-experiences';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Looking back, what experience do you feel shaped you the most?', 'Moving to a new city alone in my early twenties completely changed my confidence.'),
(@set_id, 2, 'What was the hardest part about that transition?', 'Learning to build a support system from scratch without any familiar faces around.'),
(@set_id, 3, 'How did you eventually adjust to that new environment?', 'I forced myself to say yes to more social opportunities, even when it felt uncomfortable.'),
(@set_id, 4, 'That takes a lot of courage. Did that experience change how you approach challenges now?', 'Definitely, I no longer avoid uncertainty the way I used to before that move.'),
(@set_id, 5, 'That\'s a powerful shift in mindset. Any regrets looking back on that period?', 'Only that I didn\'t make the move sooner, honestly, it was overdue.'),
(@set_id, 6, 'It sounds like it turned into a defining chapter for you.', 'It really was, I still draw on the lessons from that time regularly.'),
(@set_id, 7, 'Would you recommend a similar leap to someone hesitant about change?', 'Absolutely, though I\'d remind them to be patient with themselves along the way.'),
(@set_id, 8, 'That\'s valuable advice from real experience.', 'Thank you, it\'s something I try to remind myself of even now.'),
(@set_id, 9, 'How do you distinguish between memories that shaped you and ones that merely happened?', 'The ones that shaped me still influence decisions I make today, consciously or not.'),
(@set_id, 10, 'Do you think revisiting difficult past experiences helps or hinders moving forward?', 'It helps, if approached with reflection rather than repetitive rumination.'),
(@set_id, 11, 'What\'s an experience you initially resented but now feel grateful for?', 'A demanding early job that felt unfair then, but built discipline I still rely on.'),
(@set_id, 12, 'How has your interpretation of a specific past event changed with time?', 'A friendship ending once felt like betrayal; now I see it as mutual growth apart.'),
(@set_id, 13, 'Do you think we remember events accurately, or do we reconstruct them over time?', 'Largely reconstructed — memory seems to shift to fit our current self-narrative.'),
(@set_id, 14, 'What\'s a past experience that revealed a value you didn\'t know you held?', 'Standing up for a colleague unfairly treated revealed how much I value fairness.'),
(@set_id, 15, 'How do you separate nostalgia from an honest evaluation of the past?', 'I try to recall specific details, not just the general feeling attached to the memory.'),
(@set_id, 16, 'Do you think people are generally too quick to romanticize their past?', 'Often, yes — distance tends to soften memories more than accuracy would allow.'),
(@set_id, 17, 'What\'s an experience that fundamentally altered how you define success?', 'Achieving a long-sought goal and realizing it didn\'t bring the fulfillment I expected.'),
(@set_id, 18, 'How do you use past mistakes without letting them define your self-image?', 'I treat them as data points for growth, not permanent verdicts on my character.'),
(@set_id, 19, 'What\'s something from your past you\'re still actively making peace with?', 'A relationship that ended abruptly, without the closure I would have wanted.'),
(@set_id, 20, 'This has been a genuinely reflective conversation about the past.', 'It has — it\'s rare to unpack memories this thoughtfully in everyday conversation.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'beginner' FROM topics WHERE topic_key = 'weekend-conversation';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'What are your plans for this weekend?', 'I will relax and watch movies at home.'),
(@set_id, 2, 'That sounds relaxing! Any other plans?', 'Yes, I will also clean my house.'),
(@set_id, 3, 'Are you meeting any friends this weekend?', 'Yes, I will meet my friend on Sunday.'),
(@set_id, 4, 'What will you do together?', 'We will go to the park together.'),
(@set_id, 5, 'That sounds like a fun weekend!', 'Yes, I\'m really looking forward to it.'),
(@set_id, 6, 'Do you usually work on weekends?', 'No, I don\'t work on weekends.'),
(@set_id, 7, 'That\'s good. Rest is important.', 'Yes, I agree completely.'),
(@set_id, 8, 'Have a great weekend!', 'Thank you, you too!'),
(@set_id, 9, 'Did you sleep in this weekend?', 'Yes, I slept in on Saturday.'),
(@set_id, 10, 'Did you go anywhere this weekend?', 'Yes, I went to the market.'),
(@set_id, 11, 'What did you cook this weekend?', 'I cooked pasta for dinner.'),
(@set_id, 12, 'Did you watch any sports this weekend?', 'Yes, I watched a football match.'),
(@set_id, 13, 'Did you clean your house this weekend?', 'Yes, I cleaned the whole house.'),
(@set_id, 14, 'Did you meet any friends this weekend?', 'Yes, I met two of my friends.'),
(@set_id, 15, 'Was the weather nice this weekend?', 'Yes, it was sunny both days.'),
(@set_id, 16, 'Did you go to the gym this weekend?', 'Yes, I went on Saturday morning.'),
(@set_id, 17, 'Did you read anything this weekend?', 'Yes, I finished a short book.'),
(@set_id, 18, 'Did you rest well this weekend?', 'Yes, I feel very refreshed now.'),
(@set_id, 19, 'What was the best part of your weekend?', 'Spending time with my family.'),
(@set_id, 20, 'I hope next weekend is just as good!', 'Thank you, I hope so too.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'intermediate' FROM topics WHERE topic_key = 'weekend-conversation';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Any exciting plans for the weekend coming up?', 'Not too exciting, but I\'m planning a hike with a few friends.'),
(@set_id, 2, 'That sounds refreshing. Where are you planning to hike?', 'There\'s a trail just outside the city with a nice waterfall view.'),
(@set_id, 3, 'That sounds beautiful. How long is the hike usually?', 'It takes about three hours round trip, depending on the pace.'),
(@set_id, 4, 'Are you bringing anything special for the trip?', 'Just some snacks, water, and a camera for photos.'),
(@set_id, 5, 'Sounds like a well-planned outing.', 'Thanks, we try to plan these trips every couple of months.'),
(@set_id, 6, 'Do you have plans for Sunday as well?', 'Sunday will probably be more relaxed, maybe some reading and rest.'),
(@set_id, 7, 'That balance sounds ideal for a weekend.', 'Exactly, one active day and one lazy day works well for me.'),
(@set_id, 8, 'Enjoy your hike, it sounds like a great time!', 'Thank you, I\'ll definitely need it after a busy week.'),
(@set_id, 9, 'Did you manage to relax at all this weekend, or was it busy?', 'A bit of both, Saturday was busy but Sunday was really relaxing.'),
(@set_id, 10, 'What\'s something unexpected that happened this weekend?', 'An old friend showed up unannounced, it was a nice surprise.'),
(@set_id, 11, 'Did you try anything new this weekend?', 'Yes, I tried a new recipe that turned out surprisingly well.'),
(@set_id, 12, 'How did you balance chores and downtime this weekend?', 'I tackled chores in the morning, then left the rest of the day free.'),
(@set_id, 13, 'Did you make any weekend plans that fell through?', 'Yes, actually, our hiking plan got cancelled because of the weather.'),
(@set_id, 14, 'What\'s your favorite way to spend a lazy Sunday?', 'Coffee, a good book, and absolutely no schedule at all.'),
(@set_id, 15, 'Did you catch up with anyone you hadn\'t seen in a while?', 'Yes, I had a long overdue call with a friend from college.'),
(@set_id, 16, 'How do you usually recover from a hectic work week by the weekend?', 'Mostly just sleeping in and avoiding my phone for a bit.'),
(@set_id, 17, 'Did anything from this weekend put you in a better mood?', 'Yes, a spontaneous walk in the park really lifted my mood.'),
(@set_id, 18, 'Are you doing anything to prepare for the upcoming week?', 'Just organizing my schedule a bit so Monday isn\'t overwhelming.'),
(@set_id, 19, 'Did you spend the weekend mostly indoors or outdoors?', 'Mostly outdoors, actually, the weather was too nice to stay in.'),
(@set_id, 20, 'Sounds like a well-balanced weekend overall.', 'It really was, exactly what I needed after a long week.');

INSERT INTO conversation_sets (topic_id, level) SELECT id, 'advanced' FROM topics WHERE topic_key = 'weekend-conversation';
SET @set_id = LAST_INSERT_ID();
INSERT INTO conversation_lines (conversation_set_id, sequence_number, ai_text, suggested_answer) VALUES
(@set_id, 1, 'Do you have anything planned to unwind this weekend?', 'I\'m actually trying to disconnect completely, no work emails at all.'),
(@set_id, 2, 'That\'s a healthy boundary to set for yourself.', 'It\'s been difficult to maintain, but I\'m getting better at it lately.'),
(@set_id, 3, 'What usually helps you switch off from work mode?', 'Spending time outdoors really helps me mentally step away from everything.'),
(@set_id, 4, 'Do you have a specific activity planned outdoors this time?', 'Yes, I\'m meeting some friends for a picnic at the botanical garden.'),
(@set_id, 5, 'That sounds like the perfect low-key weekend activity.', 'It really is, plus the weather forecast looks great for it too.'),
(@set_id, 6, 'Any plans for the evening after the picnic?', 'Probably just a quiet dinner at home and an early night\'s sleep.'),
(@set_id, 7, 'That sounds like a well-rounded, restorative weekend overall.', 'That\'s the goal, I\'ve been needing this kind of reset for a while.'),
(@set_id, 8, 'I hope it turns out exactly the way you\'re hoping.', 'Thank you, I\'m really looking forward to finally slowing down.'),
(@set_id, 9, 'Do you think how we spend weekends reflects our actual priorities, or just habit?', 'Mostly habit, if I\'m honest — I default to comfort rather than intention most weekends.'),
(@set_id, 10, 'How do you decide between rest and productivity when planning your weekend?', 'I try to protect at least half the weekend purely for rest, no negotiation.'),
(@set_id, 11, 'Do you think the pressure to be \'productive\' has crept into how people rest now?', 'Definitely — even relaxation often gets optimized rather than genuinely enjoyed.'),
(@set_id, 12, 'What\'s a weekend ritual that\'s become meaningful to you over time?', 'A quiet Sunday morning walk, it\'s become almost non-negotiable at this point.'),
(@set_id, 13, 'How do you recover when a weekend ends up feeling just as draining as the week?', 'I try to identify what drained it and deliberately avoid repeating that pattern.'),
(@set_id, 14, 'Do you think unstructured weekend time is genuinely restorative, or just avoidance?', 'It depends — unstructured time helps only if it\'s chosen, not just defaulted into.'),
(@set_id, 15, 'What\'s your honest relationship with checking work messages over the weekend?', 'I\'ve gotten stricter about it, boundaries there noticeably improved my actual rest.'),
(@set_id, 16, 'How do you weigh social obligations against needing genuine alone time on weekends?', 'I try to schedule both deliberately, rather than letting one crowd out the other.'),
(@set_id, 17, 'Do you think weekends should be planned in advance or left intentionally open?', 'A mix — one anchor plan, with the rest left open to whatever feels right.'),
(@set_id, 18, 'What\'s something about your weekend habits you\'d like to change?', 'Cutting down on mindless scrolling, it eats more time than I\'d like to admit.'),
(@set_id, 19, 'How do you know when a weekend has genuinely recharged you versus just passed by?', 'If I feel curious and energized Monday morning, rather than just relieved it\'s over.'),
(@set_id, 20, 'This turned into a surprisingly reflective conversation about something so routine.', 'It did — how we rest says a lot about how we actually live.');
