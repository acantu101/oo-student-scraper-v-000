require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    products_hash = []
    html = Nokogiri::HTML(open(index_url))

    html.css(".navbar-nav ml-auto").collect do |product|
      hash = {
        name: product.css(".nav-item").text,
        product_info_url: product.css("a").attribute("href").value,
      }
      products_hash << hash
     end
     products_hash
   end

    def self.scrape_product_page(product_info_url)

      scraped_product = {}

      html = Nokogiri::HTML(open(product_info_url))

        html.css(".social-icon-container a").each do |student|
        url = student.attributes["href"].value
        # scraped_student[:bio] = html.css("div.description-holder p").text
        # scraped_student[:quote] = html.css("div.profile-quote").text
            if url.include?("twitter")
              scraped_student[:twitter] = url
            elsif url.include?("github")
              scraped_student[:github] = url
            elsif  url.include?("linkedin")
              scraped_student[:linkedin] = url
            elsif url.include?("youtube")
              scraped_student[:youtube_url] = url
            else
              scraped_student[:blog] = url

            end
          end
          scraped_student[:profile_quote] = html.css("div.profile-quote").text
          scraped_student[:bio] = html.css("div.description-holder p").text
# binding.pry
          scraped_student

      end


    end
