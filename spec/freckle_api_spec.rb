require 'spec_helper'
require 'freckle_api'

RSpec.describe FreckleApi do
  let(:base_uri) { 'https://api.letsfreckle.com/v2' }
  let(:api) { FreckleApi.new('valid_api_key') }

  describe '#project' do
    context 'given a valid project id' do
      let(:project) { api.project(37_396) }

      it 'returns the project' do
        expect(project).to be_a FreckleApi::Project
      end

      it 'contains the expected simple values' do
        expect(project.id).to eq 37_396
        expect(project.name).to eq 'Gear GmbH'
        expect(project.billing_increment).to eq 10
        expect(project.enabled).to eq true
        expect(project.billable).to eq true
        expect(project.color).to eq '#ff9898'
        expect(project.url).to eq "#{base_uri}/projects/37396"
        expect(project.minutes).to eq 180
        expect(project.billable_minutes).to eq 120
        expect(project.unbillable_minutes).to eq 60
        expect(project.invoiced_minutes).to eq 120
        expect(project.remaining_minutes).to eq 630
        expect(project.budget_minutes).to eq 750
        expect(project.entries).to eq 0
        expect(project.entries_url).to eq "#{base_uri}/projects/37396/entries"
        expect(project.expenses).to eq 0
        expect(project.expenses_url).to eq "#{base_uri}/projects/37396/expenses"
      end

      it 'contains the correct coerced timestamps' do
        expected_timestamp = DateTime.new(2012, 1, 9, 8, 33, 29)

        expect(project.created_at).to eq expected_timestamp
        expect(project.updated_at).to eq expected_timestamp
      end

      it 'contains the expected group' do
        group = project.group

        expect(group).to be_a FreckleApi::Group
        expect(group.id).to eq 3768
        expect(group.name).to eq 'Sprockets, Inc.'
        expect(group.url).to eq "#{base_uri}/project_groups/3768"
      end

      it 'contains the expected import' do
        import = project.import

        expect(import).to be_a FreckleApi::Import
        expect(import.id).to eq 8910
        expect(import.url).to eq "#{base_uri}/imports/8910"
      end

      it 'contains the expected invoices' do
        expect(project.invoices).to respond_to(:count)
        expect(project.invoices.count).to eq 1

        invoice = project.invoices.last

        expect(invoice).to be_a FreckleApi::Invoice

        expect(invoice.id).to eq 12_345_678
        expect(invoice.reference).to eq 'AA001'
        expect(invoice.invoice_date).to eq Date.new(2013, 7, 9)
        expect(invoice.state).to eq 'unpaid'
        expect(invoice.total_amount).to eq 189.33
        expect(invoice.url).to eq "#{base_uri}/invoices/12345678"
      end

      it 'contains the expected participants' do
        expect(project.participants).to respond_to(:count)
        expect(project.participants.count).to eq 1

        participant = project.participants.last

        expect(participant).to be_a FreckleApi::User
        expect(participant.id).to eq 5538
        expect(participant.email).to eq 'john.test@test.com'
        expect(participant.first_name).to eq 'John'
        expect(participant.last_name).to eq 'Test'
        expect(participant.profile_image_url).to eq(
          'https://api.letsfreckle.com/images/avatars/0000/0001/avatar.jpg')
        expect(participant.url).to eq "#{base_uri}/users/5538"
      end
    end
  end

  describe '#projects' do
    # Just smoke test for now. We've tested enough
    # of the individual project above.
    let(:projects) { api.projects }

    it 'returns a collection of projects' do
      expect(projects).to respond_to(:count)
      expect(projects.count).to eq 1
      expect(projects.last).to be_a FreckleApi::Project
    end
  end
end
