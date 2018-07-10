require 'oauth'
require 'json'


class TwitterApi

	CONSUMER_KEY = 'r7rNcZtOgRqcMVQagskuWyAP4'
	CONSUMER_SECRET = 'WXvWEqoJ6eUzNb8QLlS9KWr3wza1AzdwwduVcKF45UoUKJuP36'


	def prepare_access_token(oauth_token, oauth_token_secret)
	    consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, { :site => "https://api.twitter.com", :scheme => :header })

	    token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
	    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

	    return access_token
	end

	def get_tweets( access_t )

		content = ""

		response = access_t.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json?fromDate=201801010800&toDate=201801010815")

		result = JSON.parse(response.body)

		result.each do |tweet |
			p tweet['text']
			content += tweet['text']
		end

		content
	end



	def words_count text=nil
		text.scan(/\w+/).count
	end

	def find_stop_words( text = "" )
		stop_words = ["a", "about", "above", "above", "across", "after", "afterwards", "again", "against", "all", "almost", "alone", "along", "already", "also","although","always","am","among", "amongst", "amoungst", "amount",  "an", "and", "another", "any","anyhow","anyone","anything","anyway", "anywhere", "are", "around", "as",  "at", "back","be","became", "because","become","becomes", "becoming", "been", "before", "beforehand", "behind", "being", "below", "beside", "besides", "between", "beyond", "bill", "both", "bottom","but", "by", "call", "can", "cannot", "cant", "co", "con", "could", "couldnt", "cry", "de", "describe", "detail", "do", "done", "down", "due", "during", "each", "eg", "eight", "either", "eleven","else", "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone", "everything", "everywhere", "except", "few", "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly", "forty", "found", "four", "from", "front", "full", "further", "get", "give", "go", "had", "has", "hasnt", "have", "he", "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his", "how", "however", "hundred", "ie", "if", "in", "inc", "indeed", "interest", "into", "is", "it", "its", "itself", "keep", "last", "latter", "latterly", "least", "less", "ltd", "made", "many", "may", "me", "meanwhile", "might", "mill", "mine", "more", "moreover", "most", "mostly", "move", "much", "must", "my", "myself", "name", "namely", "neither", "never", "nevertheless", "next", "nine", "no", "nobody", "none", "noone", "nor", "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto", "or", "other", "others", "otherwise", "our", "ours", "ourselves", "out", "over", "own","part", "per", "perhaps", "please", "put", "rather", "re", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she", "should", "show", "side", "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something", "sometime", "sometimes", "somewhere", "still", "such", "system", "take", "ten", "than", "that", "the", "their", "them", "themselves", "then", "thence", "there", "thereafter", "thereby", "therefore", "therein", "thereupon", "these", "they", "thickv", "thin", "third", "this", "those", "though", "three", "through", "throughout", "thru", "thus", "to", "together", "too", "top", "toward", "towards", "twelve", "twenty", "two", "un", "under", "until", "up", "upon", "us", "very", "via", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever", "where", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "whither", "who", "whoever", "whole", "whom", "whose", "why", "will", "with", "within", "without", "would", "yet", "you", "your", "yours", "yourself", "yourselves", "the"]
		frequency = Hash.new(0)

		text.scan(/\w+/).each do |word|
			if stop_words.include?(word)
				frequency[word] += 1
			end
		end

		sorted = frequency.sort_by { |k, v | v}.reverse

		sorted.first(10).each do | k, v |
			puts " the word '#{k}' was found (#{v}) times in the text"
		end	
	end

end

	twitterApi = TwitterApi.new

	access_token = twitterApi.prepare_access_token("262982464-iqrHQs0jgySkVKa6hhSLSSZF0j5M4NYoDvigv1el", "1R2D7o3k4KBEDWaSLI7DliHfPBRercIZUtjhL6gUH63gX")

    all_tweets = twitterApi.get_tweets(access_token)

	puts "=================="
	puts " Amount of words : #{twitterApi.words_count(all_tweets)}"
	puts '=================='

  
	twitterApi.find_stop_words( all_tweets )










