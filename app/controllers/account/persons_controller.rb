module Account
require 'pipedrive-ruby'

  class PersonsController < ApplicationController

  before_action :pipedrive_authenticate

  def index
    @persons = Person.where(:active_flag=> true)

    # alphabetical(@persons)
    @organizations = Organization.all
    # pipedrive_synchronize
  end

  def edit
  end

  def update
  end


  private
    def  pipedrive_authenticate
      #Authentificate, move this methode for protect Api Token
        Pipedrive.authenticate(ENV["pipedrive_api_key"])
    end

    def pipedrive_synchronize
      @perspipes = Pipedrive::Person.all(nil, options={:query=>{:start=>0}}, true)
      pipedrive_add_new_person
      pipedrive_update_persons
    end

    def pipedrive_add_new_person
      #Add New Person from PipeDrive To Person Model
      @persons = Person.all
      @perspipes.each do |perspipe|
        if Person.where(:pipe_person_id=> perspipe.id) == []
          if perspipe.org_id != nil
            Person.create(:name=>perspipe.name, :first_name=> perspipe.first_name, :last_name=> perspipe.last_name, :email=> perspipe.email[0]['value'], :job=>perspipe['7d8dd74f3e0c0b2330cfd36ff1cae380f3cd9522'], :organization_id=>Organization.where(:pipe_organization_id=> perspipe.org_id['value']).first.id, :pipe_person_id=> perspipe.id, :phone=> perspipe.phone[0]['value'])
          end
        end
      end
    end


    def pipedrive_update_persons
      #Update Persons from PipeDrive To Person Model, Job schedule,  not use with call action user time is so long!
      #Step 1 => check all Persons & Gap select update_time
      @persons = Person.where(:active_flag=> true)


      @gaps = { :id=> nil, :name=> nil, :first_name=> nil, :last_name=> nil, :email=> nil, :job=> nil, :organization_id=> nil, :pipe_person_id=> nil, :phone=> [], :update_time=> nil }
      @lists = []

      @perspipes.each do |perspipe|
        if perspipe.org_id != nil
          if Person.where(:pipe_person_id=>perspipe.id).first != nil
            if perspipe.update_time != Person.where(:pipe_person_id=>perspipe.id).first.update_time
              @lists <<  @gaps.merge({:id =>perspipe.id, :name=>perspipe.name, :first_name => perspipe.first_name, :last_name=> perspipe.last_name,:email=> perspipe.email[0]['value'], :job=>perspipe['7d8dd74f3e0c0b2330cfd36ff1cae380f3cd9522'], :organization_id=>Organization.where(:pipe_organization_id=> perspipe.org_id['value']).first, :pipe_person_id=> perspipe.id, :phone=> perspipe.phone.first['value']})
            end
          end
        end
      end

      #Step 2 => check if Delete & Fusion from PipeDrive end update active_flag to Person
      @persons.each do |person|
        @id = person.pipe_person_id
        if @perspipes.select{ |person, id| person.id == @id} == []
          @check = Person.find(person.id)
          @check.update(active_flag: false)
        end
      end

      #Step 3 => Update Organization whith lists
      @whithlist = {:name=> nil, :first_name=> nil, :last_name=> nil, :email=> nil, :job=>nil, :phone=> nil, :organization_id=> nil}
      @lists.each do |list|
        @whithlist = {:organization_id=> list[:organization_id].id , :name=> list[:name], :first_name=> list[:first_name], :last_name=> list[:last_name],:email=> list[:email], :job=>list['7d8dd74f3e0c0b2330cfd36ff1cae380f3cd9522'], :phone=> list[:phone]}
        personup = Person.where(:pipe_person_id => list[:id]).first
        personup.update(@whithlist)
      end
    end

    def alphabetical(persons)
      # To do => Create a methode for class @persons to alphabetical  order end extrat A..to..Z
      # create a privat methode for extract first character with self[0,1]  @persons.first.first_name[0,1]
    end
    # To do =>
       # Acte if Organizations & Persons belongs to compagny
       # Make Update unik person when you click on show or update
       # Make difference between index with all person and show/edit organization with persons belongs_to organization (for help useresource_path method from pipedrive api)


  end
end
