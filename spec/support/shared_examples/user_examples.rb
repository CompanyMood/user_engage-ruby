# frozen_string_literal: true

RSpec.shared_examples 'valid user find request' do
  it 'returns an UserEngage::User object' do
    expect(subject).to be_a(UserEngage::User)
  end

  it 'sets the Users correct id' do
    expect(subject.id).to eq(72130530)
  end

  it 'sets the correct attributes' do
    attribute = subject.attributes[:attributes].first
    expect(attribute).to be_a(UserEngage::Attribute)
    expect(attribute.id).to eq(286115)

    expect(attribute.name).to eq('created_at')
    expect(attribute.name_std).to eq('created_at')
    expect(attribute.value).to eq('2015-03-13 11:45:35')
    expect(attribute.description).to eq(
      'When has that user been created? (Self or invited)'
    )
  end

  it 'sets the correct lists' do
    list = subject.lists.first
    expect(list).to be_a(UserEngage::List)
    expect(list.name).to eq('General list')
    expect(list.id).to eq(12342)
    expect(list.description).to eq('A first list')
  end

  it 'sets the correct tags' do
    tag = subject.tags.first
    expect(tag).to be_a(UserEngage::Tag)
    expect(tag.name).to eq('CompanyMood team member')
    expect(tag.id).to eq(9827)
  end
end
