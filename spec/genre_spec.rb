require_relative '../genre'
require_relative '../musicalbum'

RSpec.describe Genre do
  before :each do
    @genre = Genre.new('Pop')
    @music_album = MusicAlbum.new('Me and You', '2000-02-20', on_spotify: true)
  end

  it 'Check if it is an instance of the class' do
    expect(@genre).to be_instance_of Genre
  end

  it 'Check if it has a name attribute' do
    expect(@genre.name).to eq 'Pop'
  end

  it 'Check if it has an items attribute' do
    expect(@genre.items).to eq []
  end

  it 'Check if it can add an item to its collection' do
    @genre.add_item(@music_album)
    expect(@genre.items).to include @music_album
  end

  it 'Check if it adds itself as the item\'s genre' do
    @genre.add_item(@music_album)
    expect(@music_album.genre).to eq @genre
  end

  it 'Check if it adds the item to its items collection' do
    @genre.add_item(@music_album)
    expect(@genre.items).to include @music_album
  end

  it 'Check if it adds itself to the item\'s genres collection' do
    @genre.add_item(@music_album)
    expect(@music_album.genres).to include @genre
  end
end
