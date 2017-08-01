class WordsController < BaseController
  before_action :find_project

  def index
    @per_page = 20
    # @words = Word.find_by_sql(['select w.id, w.word, t.text,
    #   tt.text as translated_text, w.parent_id
    # From words w
    # Left join translations t on t.word_id = w.id And t.language_id = ?
    # Left join translations tt on tt.word_id = w.id And tt.language_id = ?
    # Where w.project_id = ?
    # Order by w.id ASC', @project.default_language_id, params[:language_id],
    #                            @project.id])
    @words = Word.includes(:default_translations).where(['words.project_id = ? and translations.language_id = ?', @project.id, @project.default_language_id]).references(:default_translations)
    respond_to do |format|
      format.html
      format.yaml { send_data @words.to_yaml }
      format.xls # { send_data @words.to_csv, mime_type: Mime::Type.lookup('application/xls') }
    end
  end

  def create
    @tr = Translation.find_by(language_id: params[:word][:language_id], word_id:
                                                       params[:word][:word_id])
    if @tr
      @tr.text = params[:word][:text]
    else
      @tr = Translation.new(translation_params)
    end
    @tr.save!
    render js: "alert('saved')"
  end

  private

  def find_project
    @project = Project.find_by(id: params[:project_id],
                               user_id: current_user.id)
  end

  def translation_params
    params.require(:word).permit(:word_id, :language_id, :text)
  end
end
