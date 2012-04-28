module MsgthreadsHelper
  def thread_to_id(msgthread)
    if current_user.id == msgthread.participant1_id
      return msgthread.participant2_id
    else
      return msgthread.participant1_id
    end
  end
end
