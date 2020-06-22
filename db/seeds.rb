# frozen_string_literal: true

question = Question.create!({ content: 'What is your favorite versioning tool?', position: 0 })
Awnser.create({ content: 'SVN', score: 0, question: question })
Awnser.create({ content: 'GIT', score: 10, question: question })
Awnser.create({ content: 'CSV', score: -5, question: question })
Awnser.create({ content: 'Mercurial', score: 5, question: question })
Awnser.create({ content: 'Ehh, what?', score: 0, question: question })

question = Question.create!({ content: 'What is your favorite cat?', position: 1 })
Awnser.create({ content: 'Ceiling cat', score: 10, question: question })
Awnser.create({ content: 'Invisible bike cat', score: 5, question: question })
Awnser.create({ content: 'Octocat', score: 12, question: question })
Awnser.create({ content: 'Monorail cat', score: 2, question: question })

question = Question.create!({ content: 'What is your favorite gemstone?', position: 2 })
Awnser.create({ content: 'Diamond', score: 5, question: question })
Awnser.create({ content: 'Ruby', score: 10, question: question })
Awnser.create({ content: 'Kryptonite', score: 10, question: question })
Awnser.create({ content: 'Emerald', score: -5, question: question })
