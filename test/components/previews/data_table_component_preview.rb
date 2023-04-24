# spec/lookbook/previews/data_table_component_preview.rb

class DataTableComponentPreview < Lookbook::Preview
  def sample_data
    [
      {
        arrow: true,
        icon: "user",
        text: "John Doe",
        badge: {
          template: "<span class='text-green-500'>Active</span>"
        },
        icon_with_data_1: {
          icon: "check",
          data: 5
        },
        icon_with_data_2: {
          icon: "cross",
          data: 3
        },
        progress_bar: 50,
        percent: 25,
        date: Date.today,
        avatar: {
          url: "https://via.placeholder.com/32",
          alt: "Avatar"
        },
        expanded_rows: [
          {
            text: "Dropdown Row 1",
            expanded_content: "Expanded content for dropdown row 1",
            dropdowns: [
              {
                text: "Nested Dropdown 1",
                expanded_content: "Expanded content for nested dropdown 1",
                dropdowns: []
              },
              {
                text: "Nested Dropdown 2",
                expanded_content: "Expanded content for nested dropdown 2",
                dropdowns: []
              }
            ]
          },
          {
            text: "Dropdown Row 2",
            expanded_content: "Expanded content for dropdown row 2",
            dropdowns: []
          }
        ]
      },
      {
        arrow: true,
        icon: "user",
        text: "Jane Smith",
        badge: {
          template: "<span class='text-red-500'>Inactive</span>"
        },
        icon_with_data_1: {
          icon: "check",
          data: 2
        },
        icon_with_data_2: {
          icon: "cross",
          data: 7
        },
        progress_bar: 80,
        percent: 50,
        date: Date.today - 1,
        avatar: {
          url: "https://via.placeholder.com/32",
          alt: "Avatar"
        },
        expanded_rows: [
          {
            text: "Dropdown Row 1",
            expanded_content: "Expanded content for dropdown row 1",
            dropdowns: [
              {
                text: "Nested Dropdown 1",
                expanded_content: "Expanded content for nested dropdown 1",
                dropdowns: [
                  {
                    text: "Deeply Nested Dropdown 1",
                    expanded_content: "Expanded content for deeply nested dropdown 1",
                    dropdowns: []
                  },
                  {
                    text: "Deeply Nested Dropdown 2",
                    expanded_content: "Expanded content for deeply nested dropdown 2",
                    dropdowns: []
                  }
                ]
              },
              {
                text: "Nested Dropdown 2",
                expanded_content: "Expanded content for nested dropdown 2",
                dropdowns: []
              }
            ]
          },
          {
            text: "Dropdown Row 2",
            expanded_content: "Expanded content for dropdown row 2",
            dropdowns: [
              {
                text: "Nested Dropdown 3",
                expanded_content: "Expanded content for nested dropdown 3",
                dropdowns: []
              },
              {
                text: "Nested Dropdown 4",
                expanded_content: "Expanded content for nested dropdown 4",
                dropdowns: []
              }
            ]
          }
        ]
      }
    ]
  end

  def default_view
    render(DataTableComponent.new(data: sample_data))
  end
end
