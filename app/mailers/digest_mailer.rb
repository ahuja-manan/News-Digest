class DigestMailer < ApplicationMailer

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  end 


  def send_mail
    @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY

    template_name = "news-digest"
    template_content = []
    message = {  
      to: [{email: "mananahuja14@gmail.com"}],
      subject: "Blah",
    }

    @mandrill_client.messages.send_template template_name, template_content, message
  end
end
