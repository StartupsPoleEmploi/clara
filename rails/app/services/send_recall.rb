class SendRecall

  def call(recall_id, root_url)
    recall_to_be_sent = Recall.find(recall_id)
    aid = recall_to_be_sent.aid || Aid.new
    recall_to_be_sent.status = "sent"
    recall_to_be_sent.save
    RecallMailer.with(
      email_target: recall_to_be_sent.email,
      aid_name: aid.name,
      aid_link: root_url + "/admin/aid_creation/new_aid_stage_1?modify=true&slug=" + aid.slug.to_s,
      aid_status: aid.status,
    ).recall_email.deliver_now
  end

end
