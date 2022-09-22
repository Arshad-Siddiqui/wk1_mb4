require 'cat_facts'

RSpec.describe CatFacts do
  it 'returns a catfact' do
    fact = double :fake_cat_fact
    hash_fact = {
      'fact' => 'cats are very cute'
    }
    json_fact = JSON[hash_fact]
    allow(fact).to receive(:get).with(URI("https://catfact.ninja/fact"))
    .and_return(json_fact)

    cat_facts = CatFacts.new(fact)
    expect(cat_facts.provide).to eq 'Cat fact: cats are very cute'
  end
end