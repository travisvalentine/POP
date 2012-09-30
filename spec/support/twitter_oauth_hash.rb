module TwitterOauthHash

  def self.default
    {
      "provider"=> "twitter",
      "uid" => "31983",
      "info"=> {
        "nickname" => "user",
        "name"=> "A User",
        "location" => "Washington, DC",
        "image" => "http://a0.twimg.com/profile_images/131me.jpg",
        "description" => "This is my bio",
        "urls" => {
          "Website" => "http://www.example.org/",
          "Twitter" => "http://twitter.com/example"
        }
      },
      "credentials" => {
        "token" => "1212441208098",
        "secret" => "ojf23982u3918u390ukfalk"

      }
    }
  end

  def self.updated_auth
    {
      "provider"=> "twitter",
      "uid" => "31983",
      "info"=> {
        "nickname" => "user",
        "name"=> "A User",
        "location" => "Washington, DC",
        "image" => "http://a0.twimg.com/profile_images/131me.jpg",
        "description" => "This is my bio",
        "urls" => {
          "Website" => "http://www.example.org/",
          "Twitter" => "http://twitter.com/example"
        }
      },
      "credentials" => {
        "token" => "53190u09u31",
        "secret" => "zjiwoj1830420ojdfalj13"

      }
    }
  end

end