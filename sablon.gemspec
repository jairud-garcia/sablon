# -*- encoding: utf-8 -*-

# stub: sablon 0.0.22 ruby lib

Gem::Specification.new do |s|
  s.name = "sablon".freeze
  s.version = "0.0.22"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Yves Senn".freeze]
  s.bindir = "exe".freeze
  s.date = "2023-09-08"
  s.description = "Sablon is a document template processor. At this time it works only with docx and MailMerge fields.".freeze
  s.email = ["yves.senn@gmail.com".freeze]
  s.executables = ["sablon".freeze]
  s.files = [".gitignore".freeze, ".travis.yml".freeze, "Gemfile".freeze, "Gemfile.lock".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "bin/rake".freeze, "exe/sablon".freeze, "lib/sablon.rb".freeze, "lib/sablon/content.rb".freeze, "lib/sablon/context.rb".freeze, "lib/sablon/environment.rb".freeze, "lib/sablon/html/ast.rb".freeze, "lib/sablon/html/converter.rb".freeze, "lib/sablon/html/visitor.rb".freeze, "lib/sablon/image.rb".freeze, "lib/sablon/mergeable_hash.rb".freeze, "lib/sablon/numbering.rb".freeze, "lib/sablon/operations.rb".freeze, "lib/sablon/parser/mail_merge.rb".freeze, "lib/sablon/processor/base.rb".freeze, "lib/sablon/processor/content_type.rb".freeze, "lib/sablon/processor/document.rb".freeze, "lib/sablon/processor/image.rb".freeze, "lib/sablon/processor/numbering.rb".freeze, "lib/sablon/processor/section_properties.rb".freeze, "lib/sablon/template.rb".freeze, "lib/sablon/test.rb".freeze, "lib/sablon/test/assertions.rb".freeze, "lib/sablon/version.rb".freeze, "misc/TEMPLATE.md".freeze, "misc/cv_sample.png".freeze, "misc/cv_template.png".freeze, "misc/recipe_sample.png".freeze, "misc/recipe_template.png".freeze, "misc/step_1.png".freeze, "misc/step_2.png".freeze, "misc/step_3_1.png".freeze, "misc/step_3_2.png".freeze, "misc/step_3_3_a.png".freeze, "misc/step_3_3_b.png".freeze, "misc/step_4.png".freeze, "misc/step_5.png".freeze, "misc/step_6.png".freeze, "misc/step_7.png".freeze, "sablon.gemspec".freeze, "test/content_test.rb".freeze, "test/context_test.rb".freeze, "test/environment_test.rb".freeze, "test/executable_test.rb".freeze, "test/expression_test.rb".freeze, "test/fixtures/conditionals_sample.docx".freeze, "test/fixtures/conditionals_template.docx".freeze, "test/fixtures/cv_sample.docx".freeze, "test/fixtures/cv_template.docx".freeze, "test/fixtures/html_sample.docx".freeze, "test/fixtures/image_sample.docx".freeze, "test/fixtures/image_template.docx".freeze, "test/fixtures/images/c-3po.jpg".freeze, "test/fixtures/images/r2-d2.png".freeze, "test/fixtures/insertion_template.docx".freeze, "test/fixtures/insertion_template_no_styles.docx".freeze, "test/fixtures/markdown_sample.docx".freeze, "test/fixtures/null_image_sample.docx".freeze, "test/fixtures/recipe_context.json".freeze, "test/fixtures/recipe_sample.docx".freeze, "test/fixtures/recipe_template.docx".freeze, "test/fixtures/xml/comment.xml".freeze, "test/fixtures/xml/complex_field.xml".freeze, "test/fixtures/xml/complex_field_inline_conditional.xml".freeze, "test/fixtures/xml/conditional.xml".freeze, "test/fixtures/xml/conditional_inline.xml".freeze, "test/fixtures/xml/conditional_with_predicate.xml".freeze, "test/fixtures/xml/conditional_without_ending.xml".freeze, "test/fixtures/xml/corrupt_table.xml".freeze, "test/fixtures/xml/edited_complex_field.xml".freeze, "test/fixtures/xml/loop_without_ending.xml".freeze, "test/fixtures/xml/paragraph_loop.xml".freeze, "test/fixtures/xml/paragraph_loop_within_table_cell.xml".freeze, "test/fixtures/xml/simple_field.xml".freeze, "test/fixtures/xml/simple_field_with_styling.xml".freeze, "test/fixtures/xml/simple_fields.xml".freeze, "test/fixtures/xml/table_multi_row_loop.xml".freeze, "test/fixtures/xml/table_row_loop.xml".freeze, "test/fixtures/xml/test_ignore_complex_field_spanning_multiple_paragraphs.xml".freeze, "test/html/converter_test.rb".freeze, "test/html_test.rb".freeze, "test/image_test.rb".freeze, "test/insetion_operation_test.rb".freeze, "test/mail_merge_parser_test.rb".freeze, "test/mergeable_hash_test.rb".freeze, "test/processor/document_test.rb".freeze, "test/sablon_test.rb".freeze, "test/sandbox/.gitkeep".freeze, "test/section_properties_test.rb".freeze, "test/support/document_xml_helper.rb".freeze, "test/support/xml_snippets.rb".freeze, "test/test_helper.rb".freeze]
  s.homepage = "http://github.com/senny/sablon".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "docx tempalte processor".freeze
  s.test_files = ["test/content_test.rb".freeze, "test/context_test.rb".freeze, "test/environment_test.rb".freeze, "test/executable_test.rb".freeze, "test/expression_test.rb".freeze, "test/fixtures/conditionals_sample.docx".freeze, "test/fixtures/conditionals_template.docx".freeze, "test/fixtures/cv_sample.docx".freeze, "test/fixtures/cv_template.docx".freeze, "test/fixtures/html_sample.docx".freeze, "test/fixtures/image_sample.docx".freeze, "test/fixtures/image_template.docx".freeze, "test/fixtures/images/c-3po.jpg".freeze, "test/fixtures/images/r2-d2.png".freeze, "test/fixtures/insertion_template.docx".freeze, "test/fixtures/insertion_template_no_styles.docx".freeze, "test/fixtures/markdown_sample.docx".freeze, "test/fixtures/null_image_sample.docx".freeze, "test/fixtures/recipe_context.json".freeze, "test/fixtures/recipe_sample.docx".freeze, "test/fixtures/recipe_template.docx".freeze, "test/fixtures/xml/comment.xml".freeze, "test/fixtures/xml/complex_field.xml".freeze, "test/fixtures/xml/complex_field_inline_conditional.xml".freeze, "test/fixtures/xml/conditional.xml".freeze, "test/fixtures/xml/conditional_inline.xml".freeze, "test/fixtures/xml/conditional_with_predicate.xml".freeze, "test/fixtures/xml/conditional_without_ending.xml".freeze, "test/fixtures/xml/corrupt_table.xml".freeze, "test/fixtures/xml/edited_complex_field.xml".freeze, "test/fixtures/xml/loop_without_ending.xml".freeze, "test/fixtures/xml/paragraph_loop.xml".freeze, "test/fixtures/xml/paragraph_loop_within_table_cell.xml".freeze, "test/fixtures/xml/simple_field.xml".freeze, "test/fixtures/xml/simple_field_with_styling.xml".freeze, "test/fixtures/xml/simple_fields.xml".freeze, "test/fixtures/xml/table_multi_row_loop.xml".freeze, "test/fixtures/xml/table_row_loop.xml".freeze, "test/fixtures/xml/test_ignore_complex_field_spanning_multiple_paragraphs.xml".freeze, "test/html/converter_test.rb".freeze, "test/html_test.rb".freeze, "test/image_test.rb".freeze, "test/insetion_operation_test.rb".freeze, "test/mail_merge_parser_test.rb".freeze, "test/mergeable_hash_test.rb".freeze, "test/processor/document_test.rb".freeze, "test/sablon_test.rb".freeze, "test/sandbox/.gitkeep".freeze, "test/section_properties_test.rb".freeze, "test/support/document_xml_helper.rb".freeze, "test/support/xml_snippets.rb".freeze, "test/test_helper.rb".freeze]

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new("1.2.0") then
      s.add_runtime_dependency("nokogiri".freeze, [">= 1.6.0"])
      s.add_runtime_dependency("rubyzip".freeze, [">= 1.1"])
      s.add_development_dependency("bundler".freeze, [">= 1.6"])
      s.add_development_dependency("rake".freeze, ["~> 10.0"])
      s.add_development_dependency("minitest".freeze, ["~> 5.4"])
      s.add_development_dependency("xml-simple".freeze, ["~> 1.1.5"])
      s.add_development_dependency("rexml".freeze, ["= 3.2.3"])
    else
      s.add_dependency("nokogiri".freeze, [">= 1.6.0"])
      s.add_dependency("rubyzip".freeze, [">= 1.1"])
      s.add_dependency("bundler".freeze, [">= 1.6"])
      s.add_dependency("rake".freeze, ["~> 10.0"])
      s.add_dependency("minitest".freeze, ["~> 5.4"])
      s.add_dependency("xml-simple".freeze, ["~> 1.1.5"])
      s.add_dependency("rexml".freeze, ["= 3.2.3"])
    end
  else
    s.add_dependency("nokogiri".freeze, [">= 1.6.0"])
    s.add_dependency("rubyzip".freeze, [">= 1.1"])
    s.add_dependency("bundler".freeze, [">= 1.6"])
    s.add_dependency("rake".freeze, ["~> 10.0"])
    s.add_dependency("minitest".freeze, ["~> 5.4"])
    s.add_dependency("xml-simple".freeze, ["~> 1.1.5"])
    s.add_dependency("rexml".freeze, ["= 3.2.3"])
  end
end
