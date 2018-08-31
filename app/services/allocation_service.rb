class AllocationService

  def upload(allocation, asker)
    v = allocation.type
    asker.v_allocation_type = v
    if !(v == 'ASS_AER_APS_AS-FNE' || v == 'ARE_ASP')
      asker.v_allocation_value_min = "not_applicable"
    end
  end

  def new_and_download(asker)
    allocation = AllocationForm.new
    allocation.type = asker.v_allocation_type
    allocation
  end

end
