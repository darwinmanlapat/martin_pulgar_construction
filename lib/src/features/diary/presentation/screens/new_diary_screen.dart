import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:martin_pulgar_construction/src/enum/enum.dart';
import 'package:martin_pulgar_construction/src/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:martin_pulgar_construction/src/features/diary/presentation/widgets/diary_form_fields_container.dart';
import 'package:martin_pulgar_construction/src/widgets/widgets.dart';

class NewDiaryScreen extends StatelessWidget {
  const NewDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiaryBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF000000),
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.close),
              iconSize: 24.0,
              onPressed: () {},
            ),
            title: const Text(
              'New Diary',
              style: TextStyle(
                fontSize: 28.0,
              ),
            ),
          ),
          body: const SingleChildScrollView(
            child: Column(
              children: [
                _SiteLocationWidget(),
                _SiteDiaryForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SiteLocationWidget extends StatelessWidget {
  const _SiteLocationWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.place, color: Color(0xFF616161)),
          SizedBox(
            width: 12,
          ), // Optional spacing between icon and text
          Text(
            '20041075 | TAP-NS-TAP-North Strathfield',
            style: TextStyle(
              color: Color(0xFF636363),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _SiteDiaryForm extends StatelessWidget {
  const _SiteDiaryForm();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F5F7),
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
        bottom: 40,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add to site diary',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.help,
                  color: Color(0xFF9A9A9A),
                ),
                iconSize: 24.0,
                onPressed: () {},
              ),
            ],
          ),
          const _AddSiteDiaryPhotos(),
          const SizedBox(height: 20),
          const _AddSiteDiaryComment(),
          const SizedBox(height: 20),
          const _AddSiteDiaryDetails(),
          const SizedBox(height: 20),
          const _LinkDiaryToExistingEvent(),
          const SizedBox(height: 20),
          CustomButton(
            label: 'Next',
            height: 55,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _AddSiteDiaryPhotos extends HookWidget {
  const _AddSiteDiaryPhotos();

  @override
  Widget build(BuildContext context) {
    final isChecked = useState(false);
    final stateWatch = context.watch<DiaryBloc>().state;
    final diaryEvents = context.read<DiaryBloc>();

    useEffect(() {
      return null;
    }, [stateWatch]);

    return BlocListener<DiaryBloc, DiaryState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.statusMessage!),
            ),
          );
        }
      },
      child: DiaryFormFieldsContainer(
        title: 'Add Photos to site diary',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            stateWatch.files.isEmpty
                ? const Center(
                    child: Text(
                      'No images picked.',
                      style: TextStyle(
                        color: Color(0xFF9a9a9a),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        stateWatch.files.length,
                        (index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  stateWatch.files[index],
                                  width: 75,
                                  height: 75,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: -10,
                                right: 0,
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: IconButton(
                                    icon: const Icon(Icons.cancel),
                                    onPressed: () => diaryEvents
                                        .add(RemoveDiaryPhoto(index)),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Add a photo',
              height: 55,
              onPressed: () => diaryEvents.add(AddDiaryPhotos()),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Include in photo gallery',
                  style: TextStyle(
                    color: Color(0xFF9a9a9a),
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (_) => const Color(0xFF97D700)),
                    value: isChecked.value,
                    onChanged: (bool? value) {
                      isChecked.value = value!;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddSiteDiaryComment extends HookWidget {
  const _AddSiteDiaryComment();

  @override
  Widget build(BuildContext context) {
    final diaryBloc = context.read<DiaryBloc>();

    return DiaryFormFieldsContainer(
      title: 'Comments',
      child: CustomUnderlineTextField(
        keyboardType: TextInputType.text,
        labelText: 'Comments',
        onChanged: (String text) => diaryBloc.add(CommentFieldChanged(text)),
        inputText: '',
      ),
    );
  }
}

class _AddSiteDiaryDetails extends HookWidget {
  const _AddSiteDiaryDetails();

  @override
  Widget build(BuildContext context) {
    final diaryBloc = context.read<DiaryBloc>();
    return DiaryFormFieldsContainer(
      title: 'Details',
      child: Column(
        children: [
          CustomDatePicker(
            onDateSelected: (String value) =>
                diaryBloc.add(DateFieldChanged(value)),
          ),
          const SizedBox(height: 10),
          CustomDropdownTextField(
            labelText: 'Select Area',
            dropdownItems: const [
              'Area 1',
              'Area 2',
              'Area 3',
            ],
            onItemSelected: (String text) =>
                diaryBloc.add(AreaFieldChanged(text)),
          ),
          const SizedBox(height: 10),
          CustomDropdownTextField(
            labelText: 'Task Category',
            dropdownItems: const [
              'Category 1',
              'Category 2',
              'Category 3',
              'Category 4',
              'Category 5',
              'Category 6',
              'Category 7',
              'Category 8',
              'Category 9'
            ],
            onItemSelected: (String text) =>
                diaryBloc.add(CategoryFieldChanged(text)),
          ),
          const SizedBox(height: 10),
          CustomUnderlineTextField(
            keyboardType: TextInputType.text,
            labelText: 'Tags',
            onChanged: (String text) => diaryBloc.add(TagsFieldChanged(text)),
            inputText: '',
          ),
        ],
      ),
    );
  }
}

class _LinkDiaryToExistingEvent extends HookWidget {
  const _LinkDiaryToExistingEvent();

  @override
  Widget build(BuildContext context) {
    final diaryBloc = context.read<DiaryBloc>();

    return DiaryFormFieldsContainer(
      checkboxEnabled: true,
      checkboxOnChecked: () => true,
      title: 'Link to existing event?',
      child: CustomDropdownTextField(
        labelText: 'Select an Event',
        dropdownItems: const [
          'Event 1',
          'Event 2',
          'Event 3',
        ],
        onItemSelected: (String text) => diaryBloc.add(EventFieldChanged(text)),
      ),
    );
  }
}
