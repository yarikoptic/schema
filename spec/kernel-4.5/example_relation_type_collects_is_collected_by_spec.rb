require 'spec_helper'

describe "full example" do
  let(:root) { File.join(File.dirname(__FILE__), '../../source/meta/kernel-4') }
  let(:xsd) { Dir.chdir(root) { Nokogiri::XML::Schema(File.read("metadata.xsd")) }}
  let(:doc) { Dir.chdir(root) { Nokogiri::XML(File.read("example/datacite-example-full-v4.xml")) { |c| c.strict }}}

  it 'validates' do
    expect(doc).to pass_validation(xsd)
  end

  it 'has relationType Collects' do
    related_identifiers = doc.search("relatedIdentifier[@relationType='Collects']")
    expect(related_identifiers.size).to eq(1)
    related_identifier = related_identifiers.first
    expect(related_identifier["relationType"]).to eq("Collects")
    expect(related_identifier["relatedIdentifierType"]).to eq("DOI")
    expect(related_identifier["resourceTypeGeneral"]).to eq("Other")
    expect(related_identifier.text).to eq("10.1016/j.epsl.2011.11.037")
  end

  it 'has relationType IsCollectedBy' do
    related_identifiers = doc.search("relatedIdentifier[@relationType='IsCollectedBy']")
    expect(related_identifiers.size).to eq(1)
    related_identifier = related_identifiers.first
    expect(related_identifier["relationType"]).to eq("IsCollectedBy")
    expect(related_identifier["relatedIdentifierType"]).to eq("DOI")
    expect(related_identifier["resourceTypeGeneral"]).to eq("Other")
    expect(related_identifier.text).to eq("10.1016/j.epsl.2011.11.037")
  end
end
