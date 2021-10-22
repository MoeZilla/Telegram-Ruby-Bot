require 'telegram/bot'

token = ENV['TOKEN']

QUOTES = [
    "Typical of Goku to say something that crazy…",
    "Excuse me but are you by any chance the oddball in your family?– Ash Ketchum",
    "The world isn't perfect. But it's there for us, doing the best it can....that's what makes it so damn beautiful.~ Roy Mustang (Full Metal Alchemist)",
    "To know sorrow is not terrifying. What is terrifying is to know you can't go back to happiness you could have.~ Matsumoto Rangiku (Bleach)",
    "Those who stand at the top determine what's wrong and what's right! This very place is neutral ground! Justice will prevail, you say? But of course it will! Whoever wins this war becomes justice!~ Don Quixote Doflamingo (One Piece)",
    "Fear is freedom! Subjugation is liberation! Contradiction is truth! Those are the facts of this world! And you will all surrender to them, you pigs in human clothing!~ Satsuki Kiryuuin (Kill la Kill)",
    "I am the hope of the universe. I am the answer to all living things that cry out for peace. I am protector of the innocent. I am the light in the darkness. I am truth. Ally to good! Nightmare to you!~ Son Goku (Dragon Ball Z)",
    "Religion, ideology, resources, land, spite, love or just because… No matter how pathetic the reason, it’s enough to start war. War will never cease to exist… reasons can be thought up after the fact… Human nature pursues strife.~ Paine (Naruto Shippuden)",
    "People, who can’t throw something important away, can never hope to change anything.~ Armin Arlert (Shingeki no Kyojin / Attack on Titan)",
    "I want you to be happy. I want you to laugh a lot. I don’t know what exactly I’ll be able to do for you, but I’ll always be by your side.~ Kagome (InuYasha)",
    "Thinking you’re no-good and worthless is the worst thing you can do~ Nobito (Doraemon)"
    "Don’t give up, there’s no shame in falling down! True shame is to not stand up again!~ Shintaro Midorima (Kuroko No Basket)",
    "The true measure of a shinobi is not how he lives but how he dies. It’s not what they do in life but what they did before dying that proves their worth.",
    "Knowing you’re different is only the beginning. If you accept these differences you’ll be able to get past them and grow even closer.– Miss Kobayashi",
    "Giving up is what kills people.– Hellsing",
    "No matter how deep the night, it always turns to day, eventually. – One Piece",
    "A dream is worth less than nothing if you don’t have someone else to share it.~Dousan Saitou",
    "You’ll only realize that you truly love someone if they already caused you enormous pain. Your enemies can never hurt you the way your loved ones can. It’s the people close to your heart that can give you the most piercing wound. Love is a double-edged sword, it can heal the wound faster or it can sink the blade even deeper.– Kenshin Himura",
    "I do not need a Heaven. However, if I must go to Heaven then please, God, do not divide Heaven in two. Please do not divide the robots from the humans.– Chiisana Hoshi yo Yume",
    "What you can’t accomplish alone, becomes doable when you’re with someone else.– Taichi Yaegashi",
    "Just like games, no matter how well you have things lined up in your life, there’s always something to keep you on your toes.– Junichirou Kagami",
    "Do exactly as you like. That is the true meaning of pleasure. Pleasure leads to joy and joy leads to happiness.– Gilgamesh",
    "If you can’t do something, then don’t. Focus on what you can do.~Shiroe",
    "You can call me what you like, but I will be taking your cake.-L (from Death Note)",
    "This world is rotten. The rotten should die.― Tsugumi Ohba",
    "Kakashi~Things i like and things i hate…. I don’t feel like telling you that. My dreams for the future… Never really thought about it. As for my hobbies… I have lots of hobbies",
    "Most of us can relate to Shikamaru… Genius at birth, Lazy by choice",
    "Yo momma’s so fat. Kakashi uses Kamui on her and runs out of Chakra",
    "Any girl can be glamorous. All you have to do is stand still and look stupid",
    "The moment you find the courage to give up your life for someone… would be the moment you understand love",
    "Love, passion, why do we get caught up by such troublesome feelings? The mind couldn’t ever get things straight, and you lose control to know what is sensible. Deep down it’s all so vexing",
    "Feelings you have for each other will not be known unless you voice them",
    "Sometimes good people make bad choices, it doesn’t mean they are bad people, it means they’re human. -Sui Ishida",
    "Rather than a person who hurts others, become the person getting hurt. -Sui Ishida",
    "Everybody makes a wrong turn once in a while– Ash Ketchum",
    "Make your wonderful dream a reality, it will become your truth. If anyone can, it’s you.– N, Pokemon Black/White",
    "It’s more important to master the cards you’re holding than to complain about the ones your opponent was dealt.– Grimsley",
    "We do have a lot in common. The same earth, the same air, the same sky. Maybe if we started looking at what’s the same, instead of looking at what’s different, well, who knows?– Meowth",
    "That day four years ago… When I wasn’t needed by anyone. When nobody cared about me. When I had given up on living and was about to jump off the roof of a building… FB saved me with a single message. I didn’t care if it was a joke or not. I was just happy that somebody knew… that I was alive… that it was OK for me to live.~Moeka Kiryuu",
    "Look, even if we were enemies in the world you were before, right now I’m your only ally. Even if the whole world turned against you, I would continue to be your only ally.– Moeka Kiryuu",
    "When I realized, I was already on the roof of a building… I had come to hate everything. I was sick of sitting in my room holding my knees too. If nobody was going to notice or care if I died then… what’s the point in living?~Meoka Kiryuu",
    "It is those who possess wisdom who are the greatest fools. History has shown us this. You could say that this is the final warning from God to those who resist.– Rintaro Okabe",
    "The universe has a beginning, but no end. — Infinity. Stars, too, have their own beginnings, but their own power results in their destruction. — Finite.– Rintaro Okabe"
    "Living should mean no do-overs. This is for the best.~Rintaro Okabe",
    "What kind of mad scientist worries about not getting enough vegetables?– Rintaro Okabe",
    "There are two types of lies: Lies that hurt, and lies that don’t hurt.– Itaru Hashida",
    "There are two things that collectors always want. The first is an item of extreme rarity. The second is colleagues to whom they can brag about their collection.- Kurapika",
    "People only find me interesting because they can't tell whether I'm serious or not.- Killua Zoldyck",
    "If you want to get to know someone, find out what makes them angry.- Gon Freecss",
    "It takes a mere second for treasure to turn to trash.- Hisoka Morow",
    "Human potential for evolution is limitless. - Isaac Netero",
    "You should enjoy the little detours to the fullest. Because that's where you'll find things more important than what you want.- Ging Freecss",
    "You Want To Keep Everyone From Dying? That’s Naïve. It’s War. People Die-Monkey D. Luffy",
    "Justice Will Prevail, You Say? But Of Course, It Will! Whoever Wins This War Becomes Justice!-Donquixote Doflamingo",
    "People’s Dreams... Have No Ends -Marshall 'Blackbeard' D. Teach",
    "Only I Can Call My Dream Stupid!-Roronoa Zoro",
    "When Do You Think People Die? When They Are Shot In The Heart With A Pistol? No. When They Are Ravaged By An Uncurable Disease? No. When They Drink A Soup Made From Poisonous Mushrooms? No. It’s When... They Are Forgotten!-Dr.Hiriluk",
]

TRUTH = [
    "Have you ghosted someone?"
    "Have you ever walked in on your parents doing 'it'?",
    "Who was the last person you liked the most? Why?",
    "Have you ever been suspended from school?",
    "If you had to choose between going naked or having your thoughts appear in thought bubbles above your head for everyone to read, which would you choose?",
    "What’s the one thing you’re afraid to lose?",
    "Do you like someone as of the moment?",
    "One thing about your best friend you are jealous of?",
    "Would you cheat on your boyfriend for a rich guy?",
    "What is your biggest turn on?",
    "When’s the last time you lied to your parents and why?",
    "Describe your ideal partner.",
    "What’s the scariest thing you’ve ever done?",
    "Have you ever picked your nose and eaten it?",
    "When’s the last time you lied to your parents and why?",
    "Have you ever lied about your age to participate in a contest?",
    "Have you ever been caught checking someone out?",
  
]

DARE = [
    "Show the most embarrassing photo on your phone"
    "Show the last five people you texted and what the messages said",
    "Let the rest of the group DM someone from your Instagram account",
    "Eat a raw piece of garlic",
    "Do 100 squats",
    "Keep three ice cubes in your mouth until they melt",
    "Say something dirty to the person on your leftYou've got company!",
    "Give a foot massage to the person on your right",
    "Put 10 different available liquids into a cup and drink it",
    "*Yell out the first word that comes to your mind",
    "Give a lap dance to someone of your choice",
    "Remove four items of clothing",
    "Like the first 15 posts on your Facebook newsfeed",
    "Eat a spoonful of mustard",
    "Keep your eyes closed until it's your go again",
    "Send a sext to the last person in your phonebook",
    "Show off your orgasm face",
    "Seductively eat a banana",
    "Empty out your wallet/purse and show everyone what's inside",
    "Do your best sexy crawl",
    "Pretend to be the person to your right for 10 minutes",
    "Eat a snack without using your hands",
    "Say two honest things about everyone else in the group",
    "Twerk for a minute",
    "Try and make the group laugh as quickly as possible",
    "Try to put your whole fist in your mouth",
    "Tell everyone an embarrassing story about yourself",
    "Try to lick your elbow",
    "Post the oldest selfie on your phone on Instagram Stories",
    "Tell the saddest story you know",
    "Howl like a wolf for two minutes",
    "Dance without music for two minutes",
    "Pole dance with an imaginary pole",
    "Let someone else tickle you and try not to laugh",
    "Put as many snacks into your mouth at once as you can",
    "Send your most recent selfie.",
    "Send your ugliest selfie.",
    "Send a screenshot of your facebook search history",
    "Send a screenshot of your gallery.",
    "Send a screenshot of your messenger inbox",
    "Tell something very intimate.",
    "Send a screenshot of your twitter inbox",
    "Send a screenshot of your homescreen.",
    "Send a cover of your favorite song. 🎤",
    "Do a lyric prank on someone and send proof.",
    "Confess to your current crush. ❤️",
    "Declare who is your true love.",
    "Send a screenshot of your gallery.",
    "Set your crush’s picture as your dp.",
    "Suggest me more dares.",
]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
when '/start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Hello, I am ruby bot"
      )
when '/quote'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: QUOTES.sample
      )
when '/truth'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: TRUTH.sample
      )
when '/dare'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: DARE.sample
      )
     end
  end
end
