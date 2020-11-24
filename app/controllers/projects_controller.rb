class ProjectsController < ApplicationController
  def show
  @project = Project.find(params[:id])
  end
  def index
  @projects =  current_user.projects
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.testcaseCount = 2

    fileobject = File.new("sample1.txt", "w+");
    a = 1..100
    b = a.to_a.join(' ')
    fileobject.syswrite(b);
    @test = Testcase.new(testfile: fileobject)
    @project.testcases << @test

    fileobject = File.new("sample2.txt","w+");
    a = 100..200
    b = a.to_a.join(' ')
    fileobject.syswrite(b);
    @test = Testcase.new(testfile: fileobject)
    @project.testcases << @test

    if @project.save
      flash[:notice] = "Project was created successfully."
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end

  private
  def project_params
    params.require(:project).permit(:name,:script)
  end
end
